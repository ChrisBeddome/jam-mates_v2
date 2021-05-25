# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    can [:create], Profile do |profile|
      current_user.present? && current_user.id == profile.user_id
    end
  end
end
