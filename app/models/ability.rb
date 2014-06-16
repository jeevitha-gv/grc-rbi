class Ability
  include CanCan::Ability

  def initialize(user)
      if user.is? (:company_admin)
        can :manage, :all
      else
        user_previleges =  user.user_previleges
        unless user_previleges.nil?
          user_previleges.each do |action_name, model|
            model.each do |modular|
              can modular.action_name.to_sym, modular.model_name.constantize
            end
          end
        end
      end
    end



end
