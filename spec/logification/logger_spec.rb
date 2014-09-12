describe Logification::Logger do

  subject {
    Logification::Logger.new(name: "test").tap do |l|
      l.level = :disabled
    end
  }

  describe "settings" do

    it "#level" do
      expect{subject.level}.not_to raise_error
    end

    it "#level=" do
      subject.level = :debug
      expect(subject.level).to eql(:debug)
    end

    it "#nested_count" do
      expect(subject.nested_count).to eql(0)
    end

    it "#nested_count incremented" do
      expect(subject.nested_count+=1).to eql(1)
      subject.nested_count = 0
    end

  end

  describe "inspect level state" do

    it "#debug?" do
      subject.level = :debug
      expect(subject.debug?).to eql(true)
    end


    it "#info?" do
      subject.level = :info
      expect(subject.info?).to eql(true)
    end

    it "#warn?" do
      subject.level = :warn
      expect(subject.warn?).to eql(true)
    end

    it "#error?" do
      subject.level = :error
      expect(subject.error?).to eql(true)
    end

    it "#fatal?" do
      subject.level = :fatal
      expect(subject.fatal?).to eql(true)
    end

  end

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

  describe "helper methods" do

    it "#duplicate value" do
      expect(subject.duplicate("duplicated")).not_to be_nil
    end

    it "#duplicate class" do
      expect(subject.duplicate("duplicated").class).to eql(Logification::Logger)
    end

  end

end