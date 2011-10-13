module DisplayEditDistanceOperations

  require 'RMagick'

  class Image
    def initialize(ex_path)
      @image_path = ex_path
      @img = Magick::ImageList.new(@image_path)
      @colors={:deletion => "red", :substitution => "seagreen", :insertion => "steelblue"}
    end

    def draw_edit_operations(operations_file, output_file)

      gc = Magick::Draw.new
      gc.stroke_width = 1
      gc.fill_opacity(0.5)
      operations_file.operations.each_value do |operation|
        gc.fill=@colors[operation.type]
        gc.polygon(operation.to_a)
      end
      gc.draw(@img)
      @img.display
      to_file(output_file, @img)
    end
  end
end
