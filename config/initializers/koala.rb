
Rails.application.config.action_controller.allow_forgery_protection = false
Rails.application.config.gem "koala"

module Facebook

  APP_ID = 611531139007860#Rails.application.secrets.api_key
  SECRET = "f15641fa1e4380b1bebbc6c29d9578e7"#Rails.application.secrets.api_secret
  CALLBACK_URL = "http://localhost:3000/oauth/redirect"#Rails.application.secrets.callback_url
end

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
      when 0, 1
        raise "application id and/or secret are not specified in the config" unless Facebook::APP_ID && Facebook::SECRET
        initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, Facebook::CALLBACK_URL.to_s)
      when 2, 3
        initialize_without_default_settings(*args)
    end
  end

  alias_method_chain :initialize, :default_settings
end

