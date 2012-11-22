class InvitesController < ApplicationController

  def create
    ids = params[:ids]
    ids.each do |i|
      current_user.invites << Invite.new(fb_uid: i, fb_request_id: params[:fb_request_id], concat_request_field: "#{params[:fb_request_id]}_#{i}")
    end

    render json: {success: true}
  end

end
