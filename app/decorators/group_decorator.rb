class GroupDecorator < ApplicationDecorator
  delegate_all

  delegate :name, to: :owner, prefix: true

  def user_count
    group_users.count
  end
end
