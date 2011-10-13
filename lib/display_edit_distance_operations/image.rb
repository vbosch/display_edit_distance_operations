module DisplayEditDistanceOperations

  require 'RMagick'
  require 'ruby-debug'

  class Image
    def initialize(ex_path)
      @image_path = ex_path
      @img = Magick::ImageList.new(@image_path)
      @colors={:deletion => "red", :substitution => "seagreen", :insertion => "steelblue"}
    end

    def draw_edit_operations(operations_file, output_file)

      gc = Magick::Draw.new
      gc.stroke_width = 2
      operations_file.operations.each do |operation|
        gc.fill(@colors[operation.type])
        gc.fill_opacity(0.5)
        gc.polygon(*operation.to_a(@img.columns))
      end

      gc.draw(@img)
      to_file(output_file, @img)
    end
    def to_file(path,img=@img)
      img.write(path)
    end
  end
end
