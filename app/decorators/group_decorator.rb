class GroupDecorator < ApplicationDecorator
  delegate_all

  def owner_name
    owner.name
  end

  def user_count
    group_users.count
  end
end
