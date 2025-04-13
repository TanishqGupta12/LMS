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
    @event = @course.event
  
    Stripe.api_key = @event.try(:secret_key)

  
    payment_methods = supported_payment_methods(@ticket.currency)
  
    # # Create a PaymentIntent
    payment_intent = Stripe::PaymentIntent.create(
      {
        amount: @ticket.price_cents,
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
          unit_amount: params[:total_amount].present? ? params[:total_amount].to_i * 100  : @ticket.price_cents * 100 ,
        },
        quantity: 1,
      }],
      payment_intent_data: {
        description: @event.try(:name),
        metadata: { payment_intent_id: payment_intent.id }
      },
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url,
    }
    session[:back_url] = request.referer
    session = Stripe::Checkout::Session.create(data)
  
    render json: session
  end  

  def success
    
  end

  def cancel
    
  end
end