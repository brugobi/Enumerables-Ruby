require_relative '../enumerable.rb'

describe Enumerable do
    let(:array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

    describe '#My_each' do
        it "checking my_each with block" do
            expect(array.my_each { |number| number*2 }).to eql(array.each { |number| number*2 })
        end
    end

    describe '#My_each_with_index' do
        it "checking my_each_with_index with index block given" do
            expect(array.my_each_with_index  { |num, ind| puts "item #{num} and #{ind}" }).to eql(array.each_with_index  { |num, ind| puts "item #{num} and #{ind}" })
        end
    end

    describe '#My_each_with_index' do
      block = proc { |num, ind| puts "item #{num} and #{ind}" }
        it "checking my_each_with_index with index block given" do
            expect(array.my_each_with_index(&block)  ).to eql(array.each_with_index(&block))
        end
    end

    describe '#My_select' do
      block = proc { |num, ind| puts "item #{num} and #{ind}" }
        it "checking my_select with index block given" do
            expect(array.my_select { |n| n.even? }  ).to eql(array.my_select { |n| n.even? })
        end
    end


end
