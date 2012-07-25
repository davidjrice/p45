class PeeFortyFivesController < ApplicationController

  def index
    @p45 = PeeFortyFive.new
  end

  def generate
    @p45 = PeeFortyFive.new#(params[:pee_forty_five])

    @p45.reason      = params[:reason]
    @p45.first_name  = params[:first_name]
    @p45.last_name   = params[:last_name]

    path = File.join(Rails.root, 'app/assets/images/P45.jpeg')
    p45 = Magick::ImageList.new(path)

    mark = Magick::Image.new(p45.first.columns, p45.first.rows/2)
    mark.background_color = 'transparent'
    p45.background_color = 'transparent'

    text = Magick::Draw.new
    text.annotate(mark, 0, 0, 0, 0, @p45.reason) {
        self.gravity = Magick::CenterGravity
        self.pointsize = 72
        self.stroke = 'transparent'
        self.fill = '#FF0000'
        self.font_weight = 900
    }
    mark.rotate!(-45)
    mark = mark.transparent('white')

    first_name = Magick::Draw.new
    first_name.annotate(p45, 0, 0, 180, 200, @p45.first_name) {
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 32
      self.stroke = 'transparent'
      self.fill = '#000000'
      self.font_weight = 400
    }
    last_name = Magick::Draw.new
    last_name.annotate(p45, 0, 0, 180, 248, @p45.last_name) {
      self.gravity = Magick::NorthWestGravity
      self.pointsize = 32
      self.stroke = 'transparent'
      self.fill = '#000000'
      self.font_weight = 400
    }



    result = p45.composite(mark, Magick::CenterGravity, Magick::OverCompositeOp)
    result.background_color = 'transparent'





    # p45.write('annotate.jpg')
    #response.headers["Content-type"] = p45.mime_type
    tmp = File.join(Rails.root, 'tmp/p45.jpg')
    result.write(tmp)
    #send_file tmp, :filename => 'new.p45.jpg', :content_type => "image/jpeg"
    
    #response.headers['Content-Type'] = 'image/jpeg'
    #response.headers['Content-Disposition'] = 'inline'
    #render :text => open(tmp, "rb").read
    send_data File.read(tmp), :filename => 'p45.jpg', :type => 'image/jpeg', :disposition => 'inline', :content_length => tmp.size
     
    #render :index
  end
end