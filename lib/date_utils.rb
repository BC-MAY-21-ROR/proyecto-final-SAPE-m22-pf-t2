module DateUtils
  def self.parse_month_year_date(month_year)
    return if month_year.empty?

    month_year_date = month_year.split('-')
    year = month_year_date[0].to_i
    month = month_year_date[1].to_i
    Date.new(year, month)
  end
end
