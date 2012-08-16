class PostObserver < ActiveRecord::Observer
  observe :photo
  
  def after_create(record)
    new_record = UserPhoto.new
    new_record.photo_id = record.id
    new_record.user_id = record.user_id
    new_record.save!
  end
end
