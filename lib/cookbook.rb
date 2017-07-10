require "csv"
require_relative "recipe"
require_relative "controller"
require_relative "view"

class Cookbook
  def initialize(csv_filename)
    @recipes = []
    @csv_filename = csv_filename
    arr = CSV.read(@csv_filename)
    arr.each { |y| @recipes << Recipe.new(y[0], y[1], y[2]) }
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    update_csv
  end

  def update_csv
    CSV.open(@csv_filename, "w") do |csv|
      @recipes.each { |x| csv << [x.name, x.description, x.time] }
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_csv
  end
end
