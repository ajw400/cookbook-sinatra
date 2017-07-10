# require_relative "view.rb"
class Parsing
  def self.call(ingredient)
    html_file = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?s=#{ingredient}")
    doc = Nokogiri::HTML(File.open(html_file), nil, 'utf-8')
    scrape(doc)
  end

  def self.scrape(doc)
    result = []
    doc.search('.recette_classique').each_with_index do |element, index|
      title = element.search('.m_titre_resultat')
      description = element.search('.m_texte_resultat')
      time = element.search('.m_detail_time')
      result << [title.text.strip, description.text.strip, time.text.strip]
    end
    return result
  end
end
