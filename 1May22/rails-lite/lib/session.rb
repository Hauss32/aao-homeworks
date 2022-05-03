require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie = find_or_create_cookie(req)
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie = JSON.generate(@cookie)
    res.set_cookie('_rails_lite_app', { path: '/', value: cookie })
  end

  private
  def find_or_create_cookie(req)
    cookie = req.cookies['_rails_lite_app']
    cookie ? JSON.parse(cookie) : {} 
  end
end
