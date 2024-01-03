class Manage::PointOfSales::CreateHandler
  class Params < ::SteelWheel::Params
    attribute :title, string
    attribute :place_attributes, struct do
      attribute :city, string
      attribute :address, string

      validates :city, :address, presence: true
    end

    validates :title, presence: true
  end
end
