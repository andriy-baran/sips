class Manage::Products::CreateHandler
  class Params < SteelWheel::Params
    string :id, presence: true
    has :product, presence: true do
      string :title, presence: true
      has :variants_attributes, presence: true do
        string :weight, presence: true, format: { with: /\A[0-9]+\s[g|kg]\z/ }, normalize: ->(v) { v.sub('gram', 'g') }
        string :price, presence: true
      end
    end
  end
end
