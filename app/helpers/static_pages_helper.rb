module StaticPagesHelper
  
  def page_header
    if current_page?(about_path)
      "About"
    elsif current_page?(faq_path)
      "FAQ"
    elsif current_page?(terms_path)
      "Terms"
    elsif current_page?(privacy_policy_path)
      "Privacy"
    end
  end
end