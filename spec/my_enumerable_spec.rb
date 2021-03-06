require './enumerable.rb'

describe Enumerable do
  let(:g_array) { [1, 2, 3, 4, 5] }

  describe '#my_each' do
    it 'If no block is given, an Enumerator is returned instead' do
      expect(g_array.my_each.class).to eql(g_array.each.class)
    end

    it 'returns the origin array' do
      expect(g_array.my_each { |x| x + 1 }).to eql([1, 2, 3, 4, 5])
    end

    it 'calls given block once for each element' do
      call_count = 0
      g_array.my_each { |_x| call_count += 1 }
      raise unless call_count == g_array.size
    end
  end

  describe '#my_each_with_index' do
    it 'If no block is given, an Enumerator is returned instead' do
      expect(g_array.my_each_with_index.class).to eql(g_array.each_with_index.class)
    end

    it 'returns the origin array' do
      expect(g_array.my_each_with_index { |x| x + 1 }).to eql([1, 2, 3, 4, 5])
    end

    it 'calls given block once for each element' do
      my_hash = {}
      %w[cat dog wombat].my_each_with_index do |item, index|
        my_hash[item] = index
      end

      ruby_docs_hash = {}
      %w[cat dog wombat].each_with_index do |item, index|
        ruby_docs_hash[item] = index
      end

      expect(my_hash).to eql(ruby_docs_hash)
    end
  end

  describe '#my_select' do
    it 'Returns an array containing all elements of enum for which the given block returns a true value' do
      expect((1..10).my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'If no block is given, an Enumerator is returned instead' do
      expect((1..4).my_select.class).to eql((1..4).select.class)
    end
  end

  describe '#my_all?' do
    it 'should return true if the block never returns false or nil' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should not mutate the original array' do
      g_array.my_all?
      expect(g_array).to eql([1, 2, 3, 4, 5])
    end

    it 'should return true when none of the collection members are false or nil When no block or argument is given ' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'returns true if all of the collection is a member of such class' do
      expect([1, 3, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'returns true if all of the collection matches the Regex' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'should return true if the block ever returns a value other than false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'should not mutate the original array' do
      g_array.my_any?
      expect(g_array).to eql([1, 2, 3, 4, 5])
    end

    it 'should return true if at least one of the collection is not false or nil When no block or argument is given ' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'return true if at least one of the collection is a member of such class' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end

    it 'return false if none of the collection matches the Regex' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'should return true if the block never returns true for all elements.' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to eql(false)
    end

    it 'should not mutate the original array' do
      g_array.my_none?
      expect(g_array).to eql([1, 2, 3, 4, 5])
    end

    it 'should return true only if none of the collection members is true when no block or argument is given ' do
      expect([nil, false].my_none?).to eql(true)
    end

    it 'should return true if none of the collection is a member of such class when argument is a class' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it 'should return true only if none of the collection matches the Regex when argument is Regex' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end
  end

  describe '#my_count' do
    let(:ary) { [1, 2, 4, 2] }
    it 'Returns the number of items in enum through enumeration' do
      expect(ary.my_count).to eql(4)
    end

    it 'counts the number of elements yielding a true value If a block is given' do
      expect(ary.my_count(&:even?)).to eql(3)
    end

    it 'counts the number of items in enum that are equal to item, if argument is given' do
      expect(ary.my_count(2)).to eql(2)
    end
  end

  describe '#my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      raise unless (1..4).my_map { |i| i * i } == [1, 4, 9, 16]
    end

    it 'Returns an enumerator instead If no block is given' do
      expect((1..4).my_map.class).to eql((1..4).map.class)
    end
  end

  describe '#my_inject' do
    it 'combines all elements of enum by applying a binary operation, specified by a block' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eql((5..10).inject { |sum, n| sum + n })
    end

    it 'when a symbol is specified combines each element of the collection by applying the symbol as a named method' do
      expect((5..10).my_inject(:+)).to eql((5..10).inject(:+))
    end
  end
end
