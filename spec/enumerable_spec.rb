require_relative '../enumerable.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }
  let(:words) { %w[cat dog bird] }
  let(:array_empty) { [] }
  let(:array_mixed) { [nil, true, 99] }
  let(:array_numeric) { [1, 2i, 3.14] }

  describe '#My_each' do
    it 'checking my_each with block' do
      expect(array.my_each { |number| puts number }).to eql(array.each { |number| puts number })
    end
  end

  describe '#My_each_with_index' do
    it 'checking my_each_with_index with index block given' do
      expect(array.my_each_with_index { |n, i| p " #{n}-#{i}" }).to eql(array.each_with_index { |n, i| p "#{n}-#{i}" })
    end

    block = proc { |num, ind| puts "item #{num} and #{ind}" }
    it 'checking my_each_with_index with index block given' do
      expect(array.my_each_with_index(&block)).to eql(array.each_with_index(&block))
    end
  end

  describe '#My_select' do
    it 'checking my_select with index block given' do
      expect(array.my_select(&:even?)).to eql(array.my_select(&:even?))
    end
  end

  describe '#My_all' do
    it 'checking my_all with array numbers' do
      expect(array.my_all? { |n| n > 5 }).to eql(array.all? { |n| n > 5 })
    end

    it 'checking my_all with array words' do
      expect(words.my_all? { |n| n.length > 2 }).to eql(words.all? { |n| n.length > 2 })
    end

    it 'checking my_all with array empty' do
      expect(array_empty.my_all?).to eql(array_empty.all?)
    end

    it 'checking my_all with array mixed' do
      expect(array_mixed.my_all?).to eql(array_mixed.all?)
    end

    it 'checking my_all with differents kind of numbers' do
      expect(array_numeric.my_all?(Numeric)).to eql(array_numeric.all?(Numeric))
    end
  end

  describe '#My_any' do
    it 'checking my_any with array numbers' do
      expect(array.my_any? { |n| n > 5 }).to eql(array.any? { |n| n > 5 })
    end

    it 'checking my_any with array words' do
      expect(words.my_any? { |n| n.length > 2 }).to eql(words.any? { |n| n.length > 2 })
    end

    it 'checking my_any with array empty' do
      expect(array_empty.my_any?).to eql(array_empty.any?)
    end

    it 'checking my_any with array words' do
      expect(array_mixed.my_any?).to eql(array_mixed.any?)
    end

    it 'checking my_any with array words' do
      expect(array_numeric.my_any?(Numeric)).to eql(array_numeric.any?(Numeric))
    end
  end

  describe '#My_count?' do
    it 'checking my_count with array numbers' do
      expect(array.my_count).to eql(array.count)
    end

    it 'checking my_count with array numbers passing parameters' do
      expect(array.my_count(1)).to eql(array.count(1))
    end

    it 'checking my_count with array numbers passing block' do
      expect(array.my_count(&:even?)).to eql(array.count(&:even?))
    end
  end

  describe '#My_count?' do
    it 'checking my_none with array numbers' do
      expect(array.my_none? { |n| n > 5 }).to eql(array.none? { |n| n > 5 })
    end

    it 'checking my_none with array words' do
      expect(words.my_none? { |n| n.length > 2 }).to eql(words.none? { |n| n.length > 2 })
    end

    it 'checking my_none with array empty' do
      expect(array_empty.my_none?).to eql(array_empty.none?)
    end

    it 'checking my_none with array words' do
      expect(array_mixed.my_none?).to eql(array_mixed.none?)
    end

    it 'checking my_none with array words' do
      expect(array_numeric.my_none?(Numeric)).to eql(array_numeric.none?(Numeric))
    end
  end

  describe '#My_map?' do
    it 'checking my_map with array numbers' do
      expect(array.map { |i| i * i }).to eql(array.map { |i| i * i })
    end
  end

  describe '#My_inject?' do
    it 'checking my_inject with array numbers' do
      expect(array.my_inject { |sum, n| sum + n }).to eql(array.inject { |sum, n| sum + n })
    end

    it 'checking my_inject with array numbers' do
      expect(array.my_inject(1) { |product, n| product * n }).to eql(array.inject(1) { |product, n| product * n })
    end
  end
end
