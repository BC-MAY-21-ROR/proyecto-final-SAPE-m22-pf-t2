module ApplicationHelper
  def has_path?(path)
    request.path.include? path
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
