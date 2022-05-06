require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue => e
      render_exception(e)
  end

  private

  def render_exception(e)
    @error = e
    @error_details = make_error_source_details_html(e)
    @source_code = make_error_source_code_html(e)
    file_dir = File.dirname(__FILE__)
    path = File.join(file_dir.to_s, 'templates', 'rescue.html.erb')
    template = ERB.new(File.read(path))
    content = template.result(binding)
    ['500', { 'Content-Type' => 'text/html' }, [content]]
  end

  def make_error_source_details_html(e)
    path, line_no, area = get_error_source_components(e)
    details = <<-ERROR
    <ul>
      <li><b>Error Path:</b> #{path} </br>
      <li><b>Line Number:</b> #{line_no} </br>
      <li><b>Error Near:</b> #{area}
    </ul
    ERROR
  end

  def get_error_source_components(e)
    e.backtrace.first.split(':')
  end

  def get_error_path(e)
    get_error_source_components(e)[0]
  end

  def get_error_line(e)
    get_error_source_components(e)[1].to_i
  end

  def find_source_code(e)
    line_no = get_error_line(e)
    min_line = [(line_no - 3), 0].max #in case error is at start of file
    max_line = line_no + 3
    get_source_file_lines(e, line_no, min_line, max_line)
  end

  def get_source_file_lines(e, line_no, min_line, max_line)
    path = get_error_path(e)
    code = ""
    f = File.open(path)
    f.each_with_index do |line, i|
      if i == (line_no - 1)
        code << "<span>#{line}</span></br>"
      elsif i.between?(min_line, max_line)
        code << "#{line}</br>"
      else
        break if i >= max_line
      end
    end

    f.close
    code
  end

  def make_error_source_code_html(e)
    code = find_source_code(e)
    "<code>#{code}</code>"
  end

end
