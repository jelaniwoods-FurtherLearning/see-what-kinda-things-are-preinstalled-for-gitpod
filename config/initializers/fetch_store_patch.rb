module ActionDispatch
  class Request
    class Session
      def fetch(key, *fallback)
        if keys.include?(key)
          [key]
        elsif fallback.present?
          fallback
        else
          raise KeyError, "Key not found. Could not find #{key} in session Hash." #exception
        end
      end
      alias store []=
    end
  end

  class Cookies
    class CookieJar
      def fetch(key, *fallback)
        if keys.include?(key)
          [key]
        elsif fallback.present?
          fallback
        else
          raise KeyError, "Key not found. Could not find #{key} in cookies Hash." #exception
        end
      end
      alias store []=
    end
  end
end
