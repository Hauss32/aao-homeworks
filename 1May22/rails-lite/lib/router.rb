class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern = pattern
    @http_method = http_method
    @controller_class = controller_class
    @action_name = action_name
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    path = req.path
    request_method = req.request_method.downcase.to_sym
    (path =~ @pattern && request_method == @http_method) ? true : false
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    route_params = {}
    match = req.path.match(@pattern)
    match.names.each { |name| route_params[name] = match[name] }
    con = @controller_class.new(req, res, route_params)
    con.invoke_action(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, __method__, controller_class, action_name)
    end
  end

  # should return the route that matches this request
  def match(req)
    @routes.find { |r| r.matches?(req) }
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    route = match(req)
    unless route
      res.status = 404
      res.write('Unable to find matching route.')
      return
    end
    route.run(req, res)
  end
end
