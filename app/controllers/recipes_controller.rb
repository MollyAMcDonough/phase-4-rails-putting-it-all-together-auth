class RecipesController < ApplicationController
    #GET /recipes
    def index
        if session[:user_id]
            render json: Recipe.all, status: :created
        else
            render json: {errors: ["You must be logged in to view recipes"]}, status: :unauthorized
        end
    end

    #POST /recipes
    def create
        if session[:user_id]
            user = User.find(session[:user_id])
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created
    
        else
            render json: {errors: ["You must be logged in to create a recipe"]}, status: :unauthorized
        end
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    private
    
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
