describe Logification::Helpers::LoggingMethods do

  let(:klass) {
    class LoggingKlass
      include Logification::Helpers::LoggingMethods
    end
    LoggingKlass
  }

  subject(:subject) { klass.new }

  it "#debug" do
    expect(subject.public_methods.include?(:debug)).to eql(true)
  end

  it "#info" do
    expect(subject.public_methods.include?(:info)).to eql(true)
  end

  it "#warn" do
    expect(subject.public_methods.include?(:warn)).to eql(true)
  end

  it "#error" do
    expect(subject.public_methods.include?(:error)).to eql(true)
  end

  it "#fatal" do
    expect(subject.public_methods.include?(:fatal)).to eql(true)
  end

  it "#is_nested?" do
    expect(subject.private_methods.include?(:is_nested?)).to eql(true)
  end

  it "#log_message (private)" do
    expect(subject.private_methods.include?(:log_message)).to eql(true)
  end

  it "#messagify (private)" do
    expect(subject.private_methods.include?(:messagify)).to eql(true)
  end

  it "#tabify (private)" do
    expect(subject.private_methods.include?(:tabify)).to eql(true)
  end

  describe "exception logging" do

    subject {
      Logification::Logger.new(name: "test").tap do |l|
        l.level = :disabled
      end
    }

    it "should log exceptions" do
      expect{subject.error StandardError.new("expected")}.not_to raise_error
    end

  end

end