module FormGenerator
  class DataSet
    def initialize(filenames)
      @files = filenames.map { |filename| IO.readlines(filename).map(&:strip) }
    end

    def sample
      @files.reduce("") do |memo, file|
        memo << "#{file.sample} "
      end.strip
    end
  end
end
