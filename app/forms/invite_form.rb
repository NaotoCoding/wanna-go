class InviteForm
  include ActiveModel::Model

  def initialize(group, user)
    raise ArgumentError, 'グループが存在しません' unless group&.persisted?

    @group = group
    @user = user
  end

  def save
    return group.invites.create!(user:) if invitable_user?

    false
  end

  private

    attr_reader :group, :user

    def invitable_user?
      return add_error_and_return_false(:base, :not_found) if user.blank? || user.new_record?
      return add_error_and_return_false(:base, :already_member) if group.member?(user)

      true
    end

    def add_error_and_return_false(attribute, message)
      errors.add(attribute, message)
      false
    end
end
