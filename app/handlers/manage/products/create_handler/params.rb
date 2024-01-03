class Manage::Products::CreateHandler
  class Params < SteelWheel::Params
    attribute :title, string
    attribute :weight, string
    attribute :price, string

    # validates :title, :weight, :price, presence: true
    # validates :weight, allow_blank: true, format: { with: /\A[0-9]+\s[g|kg]\z/ }
  end
end
