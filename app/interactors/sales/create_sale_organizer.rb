class Sales::CreateSaleOrganizer
  include Interactor::Organizer

  organize Sales::LoadSaleProductsFromSession,
           Sales::CalculateTotalForSaleProducts,
           Sales::CreateSale
end
