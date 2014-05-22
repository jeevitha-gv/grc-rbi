class Ability
  include CanCan::Ability

  def initialize(user)
      if user.is? :companyadmin
        can :manage, :all
      else
        user_previleges =  user.user_previleges
          user_previleges.each do |action_name, model|
            model.each do |modular|
              can modular.action_name.to_sym, modular.model_name.constantize
            end
          end
      end
    end
    
    
    
end
  