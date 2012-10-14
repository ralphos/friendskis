class WelcomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :subscription

  layout 'welcome' 
  
  def index
  end 

  def payments_callback
    items = {
      content: [
              {
                title: "BFF Locket",
                description: "Best friend locket",
                price: 1,
                image_url: "http:\/\/www.facebook.com\/images\/gifts\/21.png"
              }
            ],
      method: "payments_get_items"
    }

    render json: items, layout: false 
  end

  def subscription
    render layout: false
  end

end
