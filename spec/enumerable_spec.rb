require_relative '../enumerable.rb'

describe Enumerable do
    # let(:array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
    describe '#My_each' do
        it "checking my_each method" do
            array = [1,2,3,4]
            expect(array.my_each { |number| number*2 }).to eql(array.each { |number| number*2 })
        end 
    end       
end

