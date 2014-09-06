describe Logification do

  subject { Logification }

  it ".logger" do
    expect{subject.logger}.not_to raise_error
  end

  it ".logger should return a by default logger class" do
    expect(subject.logger.class).to eql(Logification::Logger)
  end

  it ".logger=" do
    subject.logger = Log4r::Logger.new("test")
    expect(subject.logger.class).to eql(Log4r::Logger)
  end

end