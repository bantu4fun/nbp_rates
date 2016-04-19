require 'open-uri'

namespace :nbp do
  desc "Get current year NBP exchange rates"

  task :get_nbp_rates => :environment do
    open("http://www.nbp.pl/kursy/xml/dir.txt", "r:utf-8") do |f|
      files = f.readlines.map { |line| line.strip! }.select { |line| line =~ /^c[0-9]{3}z[0-9]{6}$/ }

      files.each do |filename|
        xml_parser = XmlParser.new(filename: "#{filename}.xml")
        data = xml_parser.get_data

        puts "Save exchange for: #{data[:exchanges][:name]}"
        Exchange.new.save_current_rates(data)
      end
    end
  end
end