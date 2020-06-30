require './lib/enumerable.rb'

describe Enumerable do
  describe '#my_each' do
    it 'returns the origin array'
    it 'calls given block once for each element'
  end

  describe '#my_each_with_index' do
    it 'returns the origin array'
    it 'calls given block once for each element'
    it 'gives the index of current element'
  end

  describe '#my_select' do
    it 'Returns an array containing all elements of enum for which the given block returns a true value'
    it 'If no block is given, an Enumerator is returned instead'
  end

  describe '#my_all?' do
    it 'It should return true if the block never returns false or nil'
    it 'It should not mutate the original array'
    it 'it should return true when none of the collection members are false or nil When no block or argument is given '
    it 'returns true if all of the collection is a member of such class'
    it 'returns true if all of the collection matches the Regex'
    it 'When a pattern other than Regex or a Class is given returns true if all of the collection matches the pattern'
  end

  describe '#my_any?' do
    it 'It should return true if the block ever returns a value other than false or nil'
    it 'It should not mutate the original array'
    it 'it should return true if at least one of the collection is not false or nil When no block or argument is given '
    it 'return true if at least one of the collection is a member of such class'
    it 'return false if none of the collection matches the Regex'
    it 'return false if none of the collection matches the pattern'
  end

  describe '#my_none?' do
    it 'It should return true if the block never returns true for all elements.'
    it 'It should not mutate the original array'
    it 'it should return true only if none of the collection members is true when no block or argument is given '
    it 'when a class is passed as an argument it should return true if none of the collection is a member of such class'
    it 'when a Regex is passed as an argument it should return true only if none of the collection matches the Regex'
  end

  describe '#my_count' do
    it 'Returns the number of items in enum through enumeration'
    it 'counts the number of elements yielding a true value If a block is given'
    it 'counts the number of items in enum that are equal to item, if argument is given'
  end

  describe '#my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      raise unless (1..4).my_map { |i| i * i } == [1, 4, 9, 16]
    end
    it 'Returns an enumerator instead If no block is given' do
      expect((1..4).my_map).to eql((1..4).map)
    end
  end

  describe '#my_inject' do
    it 'combines all elements of enum by applying a binary operation, specified by a block'
    it 'when a symbol is specified combines each element of the collection by applying the symbol as a named method'
  end
end
