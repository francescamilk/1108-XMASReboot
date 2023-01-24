require 'csv'

filepath = '../gifts.csv'

CSV.foreach(filepath, col_sep: ',', quote_char: '"', headers: :first_row) do |row|
end
