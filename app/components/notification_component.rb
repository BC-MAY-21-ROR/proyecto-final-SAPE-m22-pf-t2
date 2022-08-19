# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, data:)
    @type = type
    @data = prepare_data(data)
  end

  def prepare_data(data)
    case data
    when Hash
      data
    else
      {title: data}
    end
  end

end
