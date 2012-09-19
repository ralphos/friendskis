class VisitorsController < ApplicationController

  def index
    @visitor_photos = current_user.visitor_photos
  end
end
