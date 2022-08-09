module SalesHelper
  def clients_to_options(clients)
    clients.map { |client| [client.name, client.id] }
  end
end
