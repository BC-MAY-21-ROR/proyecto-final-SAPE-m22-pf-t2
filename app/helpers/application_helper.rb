module ApplicationHelper
  def has_in_path?(path)
    request.path.include? path
  end

  def format_month_date(date)
    date.strftime('%Y-%m')
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", 'rb') do |file|
      raw file.read
    end
  end
end
