describe Logification::Logger do

  subject {
    l = Logification::Logger.new(name: "test")
    l.base_logger.outputters = []
    l
  }

  describe "with message paramater" do

    let(:message) { "Test message" }

    it "#debug(message)" do
      expect(subject.debug(message)).to eql(message)
    end

    it "#info(message)" do
      expect(subject.info(message)).to eql(message)
    end

    it "#warn(message)" do
      expect(subject.warn(message)).to eql(message)
    end

    it "#error(message)" do
      expect(subject.error(message)).to eql(message)
    end

    it "#fatal(message)" do
      expect(subject.fatal(message)).to eql(message)
    end

  end

  describe "with message block" do

    let(:message) { "Test message" }

    it "#debug(message)" do
      expect(subject.debug{message}).to eql(message)
    end

    it "#info(message)" do
      expect(subject.info{message}).to eql(message)
    end

    it "#warn(message)" do
      expect(subject.warn{message}).to eql(message)
    end

    it "#error(message)" do
      expect(subject.error{message}).to eql(message)
    end

    it "#fatal(message)" do
      expect(subject.fatal{message}).to eql(message)
    end

  end

  describe "with nesting" do

    let(:message) { "Test message" }
    let(:tabbed_message) { Logification::Logger::TAB + message }

    it "#debug(message)" do
      subject.nested_count = 1
      expect(subject.debug{message}).to eql(tabbed_message)
    end

    it "#info(message)" do
      subject.nested_count = 1
      expect(subject.info{message}).to eql(tabbed_message)
    end

    it "#warn(message)" do
      subject.nested_count = 1
      expect(subject.warn{message}).to eql(tabbed_message)
    end

    it "#error(message)" do
      subject.nested_count = 1
      expect(subject.error{message}).to eql(tabbed_message)
    end

    it "#fatal(message)" do
      subject.nested_count = 1
      expect(subject.fatal{message}).to eql(tabbed_message)
    end

  end

end