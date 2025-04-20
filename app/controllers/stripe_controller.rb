class StripeController < ApplicationController


  def discount_amount
    ticket = Ticket.find_by(id: params[:ticket])
    return { error: "Ticket not found" } unless ticket
  
    if params[:Discount].present?
      discount = Discount.where(
        "is_active = true AND code = ? AND id IN (SELECT discount_id FROM tickets WHERE id = ?)",
        params[:Discount],
        ticket.id
      ).first

      if discount.nil? || discount.blank?
        render json: { error: "Invalid or inactive discount code" }, status: :unprocessable_entity and return
      end
  

      if discount.is_percentage == true
        discounted_amount = ticket.price_cents.to_i - ((ticket.price_cents.to_i * discount.discount_amount.to_f) / 100.0)
      else
        discounted_amount = [ticket.price_cents.to_i - discount.discount_amount.to_i, 0].max
      end

    else
      discounted_amount = ticket.price_cents
    end
    
    result=  {
      discount_amount: discount.is_percentage == true ? "#{discount.discount_amount.to_i} % " : discount.discount_amount.to_i,
      total_amount: discounted_amount.to_i
    }
    render json: result

  end
  
  # Define compatible payment methods by currency
  def supported_payment_methods(currency)
    case currency.downcase
    when 'usd'
      ['card', 'amazon_pay']
    when 'inr'
      ['card'] # upi not supported in Stripe yet
    else
      ['card']
    end
  end

  def create
    session[:back_url] = nil
    @course = Course.find(params[:courseId])
    @ticket = Ticket.find(params[:ticket])
    @user = User.find(params[:userId])
    @teacher = User.find(params[:teacher])
    @event = @course.event
  
    Stripe.api_key = @event.try(:secret_key)

  
    payment_methods = supported_payment_methods(@ticket.currency)
    amount = params[:total_amount].present? ? params[:total_amount].to_i * 100  : @ticket.price_cents * 100
    # # Create a PaymentIntent
    payment_intent = Stripe::PaymentIntent.create(
      {
        amount: amount,
        currency: @ticket.currency,
        payment_method_types: payment_methods,
        receipt_email: @user.try(:email),
        description: @event.try(:name)
      }
    )
  
    data = {
      customer_email: @user.try(:email),
      client_reference_id: @user.try(:authentication_token),
      payment_method_types: payment_methods,
      line_items: [{
        price_data: {
          currency: @ticket.currency,
          product_data: {
            name: @course.title,
          },
          unit_amount: amount ,
        },
        quantity: 1,
      }],
      payment_intent_data: {
        description: @event.try(:name),
        metadata: { payment_intent_id: payment_intent.id }
      },
      metadata: {
        id: @teacher.id,
        name: @teacher.name,
        email: @teacher.email,
        authentication_token: @teacher.authentication_token,
        unit_amount: amount,
        time: Time.now
      },
      mode: 'payment',
      success_url: success_url(user_id: @user.id ,course_id: @course.id),
      cancel_url: cancel_url(),
    }
    session[:back_url] = request.referer
    session = Stripe::Checkout::Session.create(data)

    user_course = UserCourse.new
    user_course.user_id = @user.id
    user_course.course_id = @course.id
    user_course.payment_status = "Payment incomplete"
    user_course.payment_amount = amount 
    user_course.payment_details = session
    user_course.teacher_id = @teacher.id
    user_course.is_payment = false
    user_course.save
    
    render json: session
  end  

  def free_payment
    session[:back_url] = nil
    @course = Course.find(params[:courseId])
    @user = User.find(params[:userId])
    @teacher = User.find(params[:teacher])
    @event = @course.event

    user_course = UserCourse.new
    user_course.user_id = @user.id
    user_course.course_id = @course.id
    user_course.payment_status = "Free access"
    user_course.payment_amount =  "0", 
    # user_course.payment_details = session 
    user_course.teacher_id = @teacher.id
    user_course.is_payment = false
    user_course.save

    session[:back_url] = request.referer
    
    render json: {
      redirect_url: success_url(user_id: @user.id, course_id: @course.id, is_free: "free")
    }
  end

  def success
    user_course = UserCourse.find_by(user_id: params[:user_id] , course_id:params[:course_id])

    if user_course.present?
      if params[:is_free].blank? 
        user_course.update(payment_status: "Free access",time: Time.current, is_payment: true)
      else
        user_course.update(payment_status: "Payment complete",time: Time.current, is_payment: true)
      end
    end
  end

  def cancel
    
  end
end