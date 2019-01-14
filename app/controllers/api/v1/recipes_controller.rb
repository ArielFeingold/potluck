module Api::V1
    class RecipesController < ApplicationController

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
            if recipe
                render json: {status:200, recipe: recipe}
            else
                render json: {status:204, error: "Recipe not found"}
            end
        end

        def create
            recipe = Recipe.new(user_id: params[:user_id], 
                                title: params[:title], 
                                instructions: params[:instructions],
                                category: params[:category]
                                cuisine: params[:cuisine],
                                cook_time: params[:cook_time],
                                difficulty: params[:difficulty],
                                feeds: params[:feeds]
                                )
            if recipe.save
                ingredients = params[:ringredients]
                ingredients.each {|ig| recipe.ringredients.create(ingredient_id: ig.id, quantity: ig.quantity)}
            render json: {status: 200, recipe: recipe}
            else
            render json: {status: 400, errors: recipe.errors.messages}
            end
        end

        def update
            recipe = Recipe.find_by(id: params[:id])
            if recipe.update(recipe_params)
            render json: {status: 200, recipe: recipe}
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
