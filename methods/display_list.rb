def display_list(list)
  keys = list.keys

  keys.each_with_index do |gift, i|
    box = list[gift] ? "x" : " "
    puts "#{i + 1}. [#{box}] #{gift.capitalize}"
  end
end
