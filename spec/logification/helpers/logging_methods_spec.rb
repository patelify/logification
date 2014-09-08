describe Logification::Helpers::LoggingMethods do

  let(:klass) {
    class LoggingKlass
      include Logification::Helpers::LoggingMethods
    end
    LoggingKlass
  }

  subject(:instance) { klass.new }

  it "#debug" do
    expect(instance.public_methods.include?(:debug)).to eql(true)
  end

  it "#info" do
    expect(instance.public_methods.include?(:info)).to eql(true)
  end

  it "#warn" do
    expect(instance.public_methods.include?(:warn)).to eql(true)
  end

  it "#error" do
    expect(instance.public_methods.include?(:error)).to eql(true)
  end

  it "#fatal" do
    expect(instance.public_methods.include?(:fatal)).to eql(true)
  end

  it "#is_nested?" do
    expect(instance.public_methods.include?(:is_nested?)).to eql(true)
  end

  it "#log_message (private)" do
    expect(instance.private_methods.include?(:log_message)).to eql(true)
  end

  it "#messagify (private)" do
    expect(instance.private_methods.include?(:messagify)).to eql(true)
  end

  it "#tabify (private)" do
    expect(instance.private_methods.include?(:tabify)).to eql(true)
  end

end