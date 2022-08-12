module ProvidersHelper
  def providers_to_options(providers)
    providers.map { |provider| [provider.name, provider.id] }
  end
end
