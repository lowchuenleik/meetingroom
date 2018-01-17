module ApplicationHelper
  def body_class
    " home" if current_page?(root_path)
  end
  def stripe_url
    "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{ENV['CLIENT_ID']}&scope=read_write"
  end
  def disconnect_stripe_url
    "https://connect.stripe.com/oauth/deauthorize?stripe_user_id='
acct_19PLQFBGouFBnpF8'&client_id=#{ENV['CLIENT_ID']}&scope=read_write"
  end
end
