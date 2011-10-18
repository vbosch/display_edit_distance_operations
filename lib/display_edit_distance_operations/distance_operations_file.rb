module DisplayEditDistanceOperations

  class LineOperation

    attr_reader :type

    def initialize(values)

      @type = values[0].to_sym
      @hypothesis = values[1..2].map{|val| val.to_i}
      @original = values[3..4].map{|val| val.to_i}
    end

    def to_a(width)
      return [0,@original[0] ,0,@original[1] ,width-1,@original[1], width-1,@original[0]] if @type == :insertion
      return [0,@hypothesis[1] ,width-1,@hypothesis[1] ,width-1,@hypothesis[0] ,0,@hypothesis[0]] if @type == :deletion
      [0,@original[0] ,0,@original[1],width-1,@hypothesis[1] ,width-1,@hypothesis[0]]
    end
  end

  class FrontierOperation

    attr_reader :type

    def initialize(values)

      @type = values[0].to_sym
      @hypothesis = values[1].to_i
      @original = values[2].to_i
    end

    def to_a(width)
      return [0,@original,width-1,@original] if @type == :insertion
      return [0,@hypothesis,width-1,@hypothesis] if @type == :deletion
      [0,@original,width-1,@hypothesis]
    end
  end

  class DistanceOperationsFile

    attr_reader :operations
    def initialize(file_name,op_type)
      @file_name = file_name
      @operations = []
      case op_type
      when "frontier" then
          @op_rep= Object.const_get("DisplayEditDistanceOperations").const_get("FrontierOperation")
      when "line" then
          @op_rep= Object.const_get("DisplayEditDistanceOperations").const_get("LineOperation")
      else
        raise "Unimplemented operation type passed"
      end

    end

    def read
      File.open(@file_name,"r") do |file|
        while (line = file.gets)
          @operations.push(@op_rep.new(line.split))
        end
      end
    end
  end
end