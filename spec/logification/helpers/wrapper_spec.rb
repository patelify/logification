describe Logification::Helpers::Wrapper do

  let(:klass) {
    class LoggingKlass
      attr_accessor :base_logger, :nested_count, :level
      include Logification::Helpers::Wrapper
      def initialize
        @base_logger = ::Logger.new(STDERR)
        @nested_count = 0
      end
    end
    LoggingKlass
  }

  subject(:instance) { klass.new.tap do |l| l.level = :disabled end }

  it "#wrap" do
    expect(instance.public_methods.include?(:wrap)).to eql(true)
  end

  it "#base_options (private)" do
    expect(instance.private_methods.include?(:base_options)).to eql(true)
  end

  it "#start_message (private)" do
    expect(instance.private_methods.include?(:start_message)).to eql(true)
  end

  it "#end_message (private)" do
    expect(instance.private_methods.include?(:end_message)).to eql(true)
  end

  it "#summary_message (private)" do
    expect(instance.private_methods.include?(:summary_message)).to eql(true)
  end

  describe "wrap" do

    it "basic" do
      expect{instance.wrap("test")}.not_to raise_error
    end

    it "custom wrap level" do
      expect{instance.wrap("test", level: :error)}.not_to raise_error
    end

    it "no nesting" do
      expect{instance.wrap("test", nested_tabbing: false)}.not_to raise_error
    end

  end

end