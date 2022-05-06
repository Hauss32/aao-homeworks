require_relative 'mime_types'

class Static
  attr_reader :app
  
  def initialize(app)
    @app = app
  end

  def call(env)
    file = get_file(env)
    if file
      mime_type = get_mime_type(env)
      ['200', { 'Content-Type' => mime_type }, [file]]
    elsif get_file_path(env).nil?
      app.call(env)
    else
      ['404', {}, ['Could not find file']]
    end
  end

  private
  def get_file(env)
    path = make_asset_path(env)
    f = File.read(path)
    return f
  rescue
    return nil
  end

  def make_asset_path(env)
    file_dir = File.dirname(__FILE__).to_s
    file_dir = file_dir.slice(0..-5) #remove \lib
    file = get_file_path(env)
    path = File.join(file_dir, 'public', file)
  end

  def get_file_path(env)
    file_re = /^.*\/public\/(.*)$/
    path = env['REQUEST_PATH']
    re_match = path.match(file_re)
    return nil unless re_match
    file = re_match[1]
    file
  end

  def get_file_type(env)
    file_re = /^.*\/public\/.*\.(.*)$/
    path = env['REQUEST_PATH']
    re_match = path.match(file_re)
    return nil unless re_match
    file = re_match[1]
    file
  end

  def get_mime_type(env)
    file_type = get_file_type(env)
    MIME_TYPES[file_type]
  end
end
