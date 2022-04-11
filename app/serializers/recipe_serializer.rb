class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :minutes_to_complete
  belongs_to :user, only: [:username, :image_url, :bio]
end
