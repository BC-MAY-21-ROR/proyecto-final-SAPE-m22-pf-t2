class Sales::SearchProducts
  include Interactor

  def call
    context.products = (Product.search(context.query, context.business_id) if defined? context.query)
  end
end
