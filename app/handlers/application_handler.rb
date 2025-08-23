class ApplicationHandler < SteelWheel::Handler
  attr_accessor :helpers

  def form_class
    self.class.form_definition
  end

  def on_validation_success; end
end
