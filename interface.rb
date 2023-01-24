require_relative "methods/display_list"
require_relative "methods/scraper"

require 'csv'
# require_relative "methods/load_csv"
# require_relative "methods/save_to_csv"

# list   = {
#   "phone" => true,
#   "computer" => false
# }
filepath = 'gifts.csv'

#######################
filepath = 'gifts.csv'

def save_to_csv(filepath, list)
  CSV.open(filepath, 'wb', col_sep: ',', force_quotes: true, quote_char: '"') do |csv|
    csv << ['name', 'bought']

    list.each do |name, status|
      csv << [name, status]
    end
  end
end

def load_csv(filepath)
  gifts_array = []
  CSV.foreach(filepath, col_sep: ',', quote_char: '"', headers: :first_row) do |row|
    # ["cat", "false"]
    gifts_array << [row['name'], row['bought']]
  end
  gifts_array
end
#######################

list = {}
gifts_array = load_csv(filepath)

gifts_array.each do |subarray|
  name   = subarray[0]
  status = subarray[1]

  list[name] = (status == "true")
endò

puts "❄️ " * 19
puts ""
puts "🎁  Welcome to your Christmas List  🎁"
puts ""
puts "❄️ " * 19

choice = nil
until choice == "quit"
  puts "\nWhat do you want to do [ list | add | delete | mark | idea | quit ] ?"
  print "> "
  choice = gets.chomp.downcase

  case choice
  when "list"
    display_list(list)
  when "add"
    puts "What do you want to add?"
    new_gift = gets.chomp

    list[new_gift] = false
    save_to_csv(filepath, list)
  when "delete"
    display_list(list)

    puts "Which one (type index) ?"
    i = gets.chomp.to_i - 1

    gift_delete = list.keys[i]
    list.delete(gift_delete)
    save_to_csv(filepath, list)
  when "mark"
    display_list(list)

    puts "Which one (type index) ?"
    i = gets.chomp.to_i - 1

    gift_update = list.keys[i]
    list[gift_update] = !list[gift_update]
    save_to_csv(filepath, list)
  when "idea"
    puts "What are you looking for?"
    query = gets.chomp.downcase

    ideas = scraper(query)

    ideas.each_with_index do |gift, i|
      puts "#{i + 1}. #{gift}"
    end

    puts "What do you want to add (type index) ?"
    i = gets.chomp.to_i - 1

    new_gift = ideas[i]
    list[new_gift] = false
    save_to_csv(filepath, list)
  when "quit"
    puts "\nGoodbye!"
  else
    puts "Sorry, wrong input..."
  end
end
