require 'oystercard'
describe Oystercard do
    it "check if balance by default is 0" do
        expect(subject.balance).to eq 0
    end
end
