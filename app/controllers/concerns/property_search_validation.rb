class PropertySearchValidation

  include ActiveModel::Validations

  attr_accessor :lat, :lng, :marketing_type

  validates :lat, presence: true, numericality: true, :if => Proc.new { |q| q.lng.present? }
  validates :lng, presence: true, numericality: true, :if => Proc.new { |q| q.lat.present? }
  validates :marketing_type, inclusion: ['rent', 'sell']

  def initialize(params={})
    @lat, @lng, @marketing_type, @property_type = params[:lat], params[:lng], params[:marketing_type], params[:property_type]
  end

end

