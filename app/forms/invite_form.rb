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
      return add_error_and_return_false(:base, :not_found) unless user&.persisted?
      return add_error_and_return_false(:base, :already_member) if group.member?(user)
      return add_error_and_return_false(:base, :present_unanswered_invite) unless group.all_invites_answered?(user)

      true
    end

    def add_error_and_return_false(attribute, message)
      errors.add(attribute, message)
      false
    end
end
