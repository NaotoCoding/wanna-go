class PlaceDecorator < ApplicationDecorator
  delegate_all

  def display_description
    return description if description.present?

    '説明が登録されていません。'
  end
end
