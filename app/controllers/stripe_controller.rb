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
  
  def create

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {currency: 'usd',
          product_data: {
            name: @course.name,
          },
          unit_amount: @course.price_cents,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: success_url,
      cancel_url: cancel_url,
    )

    render json: { id: session.id }
  end

  def success
    
  end

  def cancel
    
  end
end