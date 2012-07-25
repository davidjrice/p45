class PeeFortyFive

  extend  ActiveModel::Naming
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  include ActiveModel::Serialization

  attr_accessor :reason, :first_name, :last_name

  def initialize(params={})
    params.each do |k,v|
      send("#{k}=", v)
    end
  end

  def persisted?
    false
  end

end
