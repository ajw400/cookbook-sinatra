class Recipe
  attr_reader :name, :description, :time, :tried
  def initialize(name, description, time = 0)
    @name = name
    @description = description
    @time = time
    @tried = false
  end

  def tried=(value)
    @tried = value
  end
end

