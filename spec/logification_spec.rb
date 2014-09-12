describe Logification do

  it ".logger" do
    expect{subject.logger}.not_to raise_error
  end

  it ".logger should return a by default logger class" do
    expect(subject.logger.class).to eql(Logification::Logger)
  end

  it ".logger=" do
    class LoggingKlass; end
    saved_logger = subject.logger
    subject.logger = LoggingKlass.new
    expect(subject.logger.class).to eql(LoggingKlass)
    subject.logger = saved_logger
  end

  it ".level" do
    expect{subject.level}.not_to raise_error
  end

  it ".level=" do
    subject.level = :debug
    expect(subject.level).to eql(:debug)
  end

end