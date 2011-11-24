module DisplayEditDistanceOperations

  require 'RMagick'
  require 'ruby-debug'
  require 'ap'

  class Image
    def initialize(ex_path)
      @image_path = ex_path
      @img = Magick::ImageList.new(@image_path)
      @colors={:deletion => "red", :substitution => "seagreen", :insertion => "steelblue"}
    end

    def draw_edit_operations(operations_file, output_file)

      gc = Magick::Draw.new
      gc.stroke_width(3)
      operations_file.operations.each do |operation|

        if operation.draw_primitive == "polygon"
          gc.fill(@colors[operation.type])
        else
          gc.stroke(@colors[operation.type])
        end

        gc.fill_opacity(0.5)
        gc.send(operation.draw_primitive,*operation.to_a(@img.columns))
      end

      gc.draw(@img)
      to_file(output_file, @img)
    end
    def to_file(path,img=@img)
      img.write(path)
    end
  end
end
