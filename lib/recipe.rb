class Recipe
  attr_reader :name, :description, :time
  def initialize(name, description, time = 0)
    @name = name
    @description = description
    @time = time
  end
end

