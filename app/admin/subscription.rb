ActiveAdmin.register Subscription do
menu :if => proc{ current_admin_user.present? }
  #authentication
  controller do
    before_filter :authenticate_admin_user!
    before_filter :check_subdomain

    def create
      params[:subscription][:section_ids] = params[:subscription][:section_ids].reject{|x| !x.present?}
      @subscription = Subscription.new(params[:subscription])
      if @subscription.save         
        redirect_to admin_subscriptions_path
      else
        render "new"
      end
    end

    private

    def subscription_params
      params.require(:subscription).permit(:name,:description,{:section_ids =>[]},:amount, :valid_log,:valid_period)
    end

  end

  index do
    column :name
    column :description
    column "Section" do |c|
      Section.where("id IN (?)",c.section_ids).map(&:name).join(",")
    end
    column :amount
    column :valid_log
    column :valid_period do |c|
      c.valid_period == 1 ? "Days" : c.valid_period == 2 ? "Months" : "Year"
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row "Section" do |sec|     
       Section.where("id IN (?)",sec.section_ids).map(&:name).join(",")
      end
      row :amount
      row :valid_log
      row :valid_period do |period|
        period.valid_period == 1 ? "Days" : period.valid_period == 2 ? "Months" : "Year"
      end
   end
  end

  form do |f|

       f.inputs "New Subscription" do
       f.input :section_ids, label: 'Section', as: :select,multiple: true,collection: Section.all.collect{|x| [x.name,x.id]},prompt: "--Select Section--"
       f.input :name
       f.input :description
       f.input :amount
       f.input :valid_log
       f.input :valid_period,as: :select,collection: [['Days', '1'], ['Months', '2'],['Year','3']],prompt: "--Select Valid Period--"
      end
    f.actions
  end

end