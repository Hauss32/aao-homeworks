require 'json'

class Flash
    attr_reader :now

    def initialize(req)
        @flash = {}
        @now = get_or_create_flash(req)
    end

    def [](key)
        @now[key.to_s] || @flash[key.to_s]
    end

    def []=(key, value)
        @flash[key] = value
    end

    def store_flash(res)
        flash = @flash.to_json
        res.set_cookie('_rails_lite_app_flash', { path: '/', value: flash})
    end

    private
    def get_or_create_flash(req)
        flash = req.cookies['_rails_lite_app_flash']
        flash ? JSON.parse(flash) : {}
    end
end
