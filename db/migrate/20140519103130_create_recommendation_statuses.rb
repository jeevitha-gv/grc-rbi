class CreateRecommendationStatuses < ActiveRecord::Migration
  def change
    create_table :recommendation_statuses do |t|
      t.string :name

      t.timestamps
    end
     RecommendationStatus.create([{name: 'Opened Recommendation'}])
     RecommendationStatus.create([{name: 'Risk accepted for Recommendation'}])
     RecommendationStatus.create([{name: 'Closed Recommendation'}])
     RecommendationStatus.create([{name: 'Closed duplicate Recommendation'}])

  end
end
