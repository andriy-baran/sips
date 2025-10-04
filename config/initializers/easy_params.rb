EasyParams.register_type(:money, &:to_money)
EasyParams.register_type(:weight) do |val|
  Unitwise(*val.split(' '))
end