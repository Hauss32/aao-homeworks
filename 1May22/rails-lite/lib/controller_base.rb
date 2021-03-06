require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params={})
    @req = req
    @res = res
    @params = route_params.merge!(req.params)
  end

  def self.protect_from_forgery
    @@authenticity_token ||= SecureRandom.urlsafe_base64
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!@already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'Content already rendered.' if already_built_response?
    @res.redirect(url, 302)
    @already_built_response = true
    session.store_session(@res)
    flash.store_flash(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'Content already rendered.' if already_built_response?
    flash.store_flash(@res)
    @res['Content-Type'] = content_type
    @res.write(content)
    @already_built_response = true
    session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    class_name = self.class.name.underscore
    file_dir = File.dirname(__FILE__)
    path = File.join(file_dir.to_s, 'views', class_name, template_name.to_s+'.html.erb')
    template = ERB.new(File.read(path))
    render_content(template.result(binding), 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    unless req.request_method == 'GET'
      raise 'Authenticity could not be validated' unless check_authenticity_token
    end
    self.send(name)
    render(name) unless already_built_response?
  end

  def form_authenticity_token
    auth_token = self.class.protect_from_forgery
    res.set_cookie('_rails_lite_auth_token', { path: '/', value: auth_token })
    auth_token
  end

  private

  def check_authenticity_token
    auth_token = req.cookies['_rails_lite_auth_token']
    form_auth_token = params['authenticity_token']
    auth_token == form_auth_token ? true : false
  end
end

