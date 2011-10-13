module DisplayEditDistanceOperations

  class Operation

    attr_reader :type

    def initialize(values)

      @type = values[0].to_sym
      @hypothesis = values[1..2].map{|val| val.to_i}
      @original = values[3..4].map{|val| val.to_i}
    end

    def to_a(width)
      return [0,@original[0] ,0,@original[1] ,width-1,@original[1], width-1,@original[0]] if @type == :insertion
      return [0,@original[1] ,width-1,@hypothesis[1] ,width-1,@hypothesis[0] ,0,@original[1]] if @type == :deletion
      [0,@original[0] ,0,@original[1],width-1,@hypothesis[1] ,width-1,@hypothesis[0]]
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
          @operations.push(Operation.new(line.split))
        end
      end
    end
  end
end