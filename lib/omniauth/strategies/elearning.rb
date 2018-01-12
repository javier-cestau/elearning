module OmniAuth
  module Strategies
    class Elearning < OmniAuth::Strategies::OAuth2
      option :name, 'elearning'
      option :client_options, {
        site:          'https://auth.leiros.com',
        authorize_url: '/oauth/authorize'
      }

      uid {
        raw_info['id']
      }

      info do
        {
          email: raw_info['email'],
          password: raw_info['password'],
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('home/index').parsed
      end

      def callback_url
        'https://academia.leiros.com' + script_name + callback_path
      end


    end
  end
end
