module ApplicationHelper
    def auth_token_helper
        "<input 
            type=\"hidden\" 
            name=\"authenticity_token\" 
            value=#{ form_authenticity_token}>".html_safe
    end

    def shorten_link_content(string, length=40)
        if string.length <= length
            return string
        else
            return "#{string[0...40]}..."
        end
    end
end
