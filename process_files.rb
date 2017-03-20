# read in the following:
# - priorities - get list of names and codes
# - priority progam mapping - indicates which priorities are assigned ot which progams
# - names by years - list of all programs for each year

# for each name in year, assign priority to program
# - if no match -> NA


require 'rubyXL'
require 'csv'

start = Time.now

# format: [name, code]
priorities = CSV.read('priorities.csv')

# format: [priority name, year, program code]
mappings = CSV.read('priority_program_mapping.csv')

# format: [code, type, 2012 name, 2013 name, ...]
names_path = '../Georgian-Budget-Unique-Names-by-Year/names_by_year.csv'
if !File.exists? names_path
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  puts "ERROR - The Georgian Budget Unique Names by Year repo or names_by_year.csv file in the repo could not be found."
  puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  return
end
names_by_year = CSV.read(names_path)

puts "there are #{priorities.length} priorities"
puts "there are #{names_by_year.length} names_by_year"
puts "there are #{mappings.length} mappings"

# format: [code, type, name, priority code, year]
output = [] 
years = mappings[1..-1].map{|x| x[1]}.uniq.sort
years.each_with_index do |year, year_index|
  puts "------------------------"
  puts "year = #{year}"

  names_by_year[1..-1].each do |name|
    # start the output with code, type and name
    out = [name[0], name[1], name[2+year_index].nil? ? nil : name[2+year_index].strip]

    if out[2].nil? || out[2].empty?
      out << 'NA'
    else

      # look for the matching mapping
      result = mappings.select{|x| x[1].strip == year.strip && x[2].strip == name[0].strip}.first
      if result.nil?
        out << 'NA'
      else
        # found match, get priority code
        result_priority = priorities.select{|x| x[0].strip == result[0].strip}.first
        if result_priority.nil?
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
          puts "ERROR - could not find the priority '#{result[0]}' in the list of priorities (year = #{year}; code = #{name[0]})"
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
          return
        else
          out << result_priority[1]
        end
      end
    end

    out << year

    # add to the output
    output << out
  end
end

puts "========"
puts "there are #{output.length} items recorded"

# create csv output:
# format: [code, type, name, priority code, year]
CSV.open("priority_associations.csv", 'wb') do |csv|
  header = %w{code type name priority_code year}
  csv << header

  output.each do |row|
    csv << row
  end
end

puts "========"
puts "it took #{Time.now-start} seconds to process files"