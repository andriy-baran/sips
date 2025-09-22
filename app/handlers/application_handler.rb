class ApplicationHandler < SteelWheel::Handler
  params do
    string :controller
    string :action
  end
end
