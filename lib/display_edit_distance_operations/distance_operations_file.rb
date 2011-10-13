module DisplayEditDistanceOperations

  class Operation

    attr_reader :type

    def initialize(values)

      @type = values[0].to_sym
      @hypothesis = values[1..2].map{|val| val.to_i}
      @original = values[3..4].map{|val| val.to_i}
    end

    def to_a
      return [@original[0],0,@original[1],0,@hypothesis[1],@img.columns] if @type == :insertion
      return [@original[1],0,@hypothesis[1],0,@hypothesis[0],@img.columns] if @type == :insertion
      [@original[0],0,@original[1],0,@hypothesis[1],@img.columns,@hypothesis[0],@img.columns]
    end
  end

  class DistanceOperationsFile

    attr_reader :operations
    def initialize(file_name)
      @file_name = file_name
      @operations = []
    end

    def read
      File.open(@file_name,"r") do |file|
        while (line = file.gets)
          @operations.push(Operation.new(line))
        end
      end
    end
  end
end