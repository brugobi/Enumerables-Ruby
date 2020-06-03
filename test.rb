load 'enumerable.rb'

def multiply_els(arr)
  arr.my_inject { |sum, n| sum * n }
end

arr = [2, 4, 5]

puts multiply_els(arr)

# arr = [5, 6, 7, 8, 9, 10]

# puts arr.my_inject(:+) #=> 45

# puts arr.my_inject { |sum, n| sum + n } #=> 45

# puts arr.my_inject(1, :*) #=> 151200

# puts arr.my_inject(1) { |product, n| product * n } #=> 151200
# # find the longest word
# longest = %w[cat sheep bear].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest #=> "sheep"
