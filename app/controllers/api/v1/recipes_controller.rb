require 'pry-remote'
module Api::V1
    class RecipesController < ApplicationController
    before_action :authenticate_user, only: [:index, :show]
        def index
            recipes = current_user.recipes
            if !current_user.recipes.empty?
                render json: {status:200, recipes: recipes}
            else
                render json: {status:204, msg: "No Recipes Found"}
            end
        end

        def show
            recipe = Recipe.find_by(id: params[:id])
            recipe_ingredients = Ringredient.where(recipe_id: recipe.id)
            if recipe
                render json: {status:200, recipe: recipe, ingredients: recipe_ingredients}
            else
                render json: {status:204, error: "Recipe not found"}
            end
        end

        def create
            recipe = Recipe.new(recipe_params)
            if recipe.save
                ingredients = params[:ringredients]
                ingredients.each {|ig| recipe.ringredients.create(recipe_id: recipe.id, ingredient_id: ig[:ingredient_id], quantity: ig[:quantity])}
                recipe_ingredients = Ringredient.where(recipe_id: recipe.id)
            render json: {status: 200, recipe: recipe, ingredients: recipe_ingredients}
            else
            render json: {status: 400, errors: recipe.errors.messages}
            end
        end

        def update
            recipe = Recipe.find_by(id: params[:id])
            if recipe.update(recipe_params)
                ingredients = recipe.ringredients
                new_ingredients = params[:ringredients]
                new_ingredients.each {|i| 
                    current_ingredient = ingredients.find {|x| x.ingredient_id === i[:ingredient_id]}
                    if current_ingredient
                        if i[:quantity] === 0
                            Ringredient.find_by(id: current_ingredient.id).destroy
                        else
                           Ringredient.find_by(id: current_ingredient.id).update(quantity: i[:quantity])
                        end
                    else 
                        recipe.ringredients.create(recipe_id: recipe.id, ingredient_id: i[:ingredient_id], quantity: i[:quantity])
                    end
                }
            recipe_ingredients = Ringredient.where(recipe_id: recipe.id)
            render json: {status: 200, recipe: recipe, ingredients: recipe_ingredients}
            else
            render json: {status: 400, errors: recipe.errors.messages}
            end
        end

        def destroy
            Recipe.find_by(id: params[:id]).destroy
        end

        private

        def recipe_params
            params.require(:recipe).permit(:title, :instructions, :category, :user_id, :cuisine, :cook_time, :difficulty, :feeds )
        end
    end
end
