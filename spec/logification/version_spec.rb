describe Logification do

  subject {Logification}

  it "VERSION" do
    expect{subject::VERSION}.not_to raise_error
  end

  it "VERSION has valid value" do
    expect(subject::VERSION).to match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/)
  end

end