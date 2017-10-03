class Movie < ActiveRecord::Base
    def self.find_in_tmdb(string)
        Tmdb::Movie.find(string)
    end
    
  def self.to_csv(options = {})
      CSV.generate(options) do |csv|
          csv << column_names
          all.each do |movie|
              csv << movie.attributes.values_at(*column_names)
          end
      end
  end
  def self.import(file)
      CSV.foreach(file.path, headers:true ) do |row|
          Movie.create! row.to_hash
      end
  end
end
