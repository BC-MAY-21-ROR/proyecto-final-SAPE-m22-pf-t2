class Sales::RemoveProductFromSaleInSessionOrganizer
  include Interactor::Organizer

  organize Sales::RemoveProductFromSaleInSession,
           Sales::LoadSaleProductsFromSession,
           Sales::CalculateTotalForSaleProducts
end
