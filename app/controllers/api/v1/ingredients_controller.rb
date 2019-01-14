module Api::V1
    class IngredientsController < ApplicationController
        def create
            ingredient = Ingredient.new(ingredient_params)
            if ingredient.save
            render json: {status: 200, ingredient: ingredient}
            else
            render json: {status: 400, errors: ingredient.errors.messages}
            end
        end

        def show
        end


        private

        def ingredient_params
            params.require(:ingredient).permit(:name, :unit, :user_id)
        end
    end
end
