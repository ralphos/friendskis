class InvitesController < ApplicationController

  def create
    ids = params[:ids]

    ids = [] if ids.blank?

    ids.each do |i|
      current_user.invites << Invite.new(fb_uid: i, fb_request_id: params[:fb_request_id], concat_request_field: "#{params[:fb_request_id]}_#{i}")
    end

    if current_user && current_user.invites.count >= 25 && current_user.trial_start_at.nil?
      current_user.trial_start_at = DateTime.now
      current_user.trial_end_at = current_user.trial_start_at + 2.weeks
      current_user.save
    end

    render json: {success: true, invite_count: current_user.invites_remaining}
  end

end
