class P45Controller < ApplicationController

  def index
    require 'RMagick'
    path = File.join(Rails.root, 'app/assets/images/p45.jpeg')
    p45 = Magick::ImageList.new(path)
    text = Magick::Draw.new

    text.annotate(p45, 0, 0, 0, 60, params[:text]) {
        self.gravity = Magick::SouthGravity
        self.pointsize = 64
        self.stroke = 'transparent'
        self.fill = '#FF0000'
        self.font_weight = Magick::BoldWeight
        }
    #text.rotate!(-45)
    # p45.write('annotate.jpg')
    response.headers["Content-type"] = p45.mime_type
    tmp = File.join(Rails.root, 'tmp/p45.jpg')
    p45.write(tmp)
    send_file tmp, :filename => 'new.p45.jpg'
  end
end