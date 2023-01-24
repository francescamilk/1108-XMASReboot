require 'csv'

filepath    = 'gifts.csv'

CSV.open(filepath, 'wb', col_sep: ',', force_quotes: true, quote_char: '"') do |csv|
  csv << ['name', 'bought']
end
