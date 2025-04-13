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
  
      if discount.present?
        if discount.is_percentage == true
          discounted_amount = ticket.price_cents.to_i - ((ticket.price_cents.to_i * discount.discount_amount.to_f) / 100.0)
        else
          discounted_amount = [ticket.price_cents.to_i - discount.discount_amount.to_i, 0].max
        end
      else
        render json: { error: "Invalid or inactive discount code", ticket: ticket }
      end
    else
      discounted_amount = ticket.price_cents
    end
    
    result=  {
      discount_amount: discount.discount_amount.to_i,
      total_amount: discounted_amount.to_i
    }
    render json: result

  end
  
  def create
    
  end
end