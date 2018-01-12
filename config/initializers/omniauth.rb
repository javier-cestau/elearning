require File.expand_path('lib/omniauth/strategies/elearning',Rails.root)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elearning , ENV["OMNI_KEY"], ENV["OMNI_SECRET"], :strategy_class => OmniAuth::Strategies::OAuth2
end
