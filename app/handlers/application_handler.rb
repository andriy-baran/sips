class ApplicationHandler < SteelWheel::Handler
  def initialize(params)
    if params.is_a?(Hash)
      self.class.params self.class.form_definition.new.schema_definition
      super(params.symbolize_keys)
    elsif params.is_a?(ActionController::Parameters)
      super(params.to_unsafe_h.symbolize_keys)
    end
  end

  class << self
    attr_accessor :form_definition

    def form(klass = nil, &block)
      self.form_definition = klass || Class.new(EasyForm::Base)
      form_definition.class_eval(&block) if block
    end

    def ask(input, &block)
      yield new(input).form if block
    end
  end

  def form_class
    self.class.form_definition
  end

  def on_validation_success; end
end
