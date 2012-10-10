module CommonHelpers

  def sign_in(user)
    visit "/sessions/test_login?user_id=#{user.id}"
  end

end
