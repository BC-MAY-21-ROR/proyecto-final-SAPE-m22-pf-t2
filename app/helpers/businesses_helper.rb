module BusinessesHelper
  def countries_to_options(countries)
    countries.map { |country| [country.name, country.id] }
  end

  def enrollments_to_options(enrollments)
    enrollments.map { |enrollment| [enrollment.business.name, enrollment.business.id] }
  end
end
