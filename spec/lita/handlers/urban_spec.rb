require "spec_helper"

describe Lita::Handlers::Urban, lita_handler: true do
  it { is_expected.to route_command("urban me something") }
  it { is_expected.to route_command("urban me something").to(:define_word) }
  it { is_expected.to route_command("urban something") }
  it { is_expected.to route_command("urban something").to(:define_word) }

  it "can define a word with urban dictionary" do
    send_command("urban me dogfooding")
    expect(replies.count).to eq 1
    expect(replies.last).to_not be_nil
    expect(replies.last).to match /software developers/
  end


end
