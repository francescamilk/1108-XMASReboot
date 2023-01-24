require "nokogiri"
require "open-uri"

def scraper (query)
  html_content = URI.open("https://www.etsy.com/search?q=#{query}", "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML.parse(html_content)
  
  ideas = []
  doc.search('.v2-listing-card__info .v2-listing-card__title').take(5).each do |element|
    ideas << element.text.strip
  end
  ideas
end
