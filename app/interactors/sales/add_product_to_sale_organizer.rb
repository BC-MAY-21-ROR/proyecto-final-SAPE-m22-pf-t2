class Sales::AddProductToSaleOrganizer
  include Interactor::Organizer

  organize Sales::SaveProductToSaleInSession,
           Sales::LoadSaleProductsFromSession,
           Sales::CalculateTotalForSaleProducts
end
