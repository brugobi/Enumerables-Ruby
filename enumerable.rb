module Enumerable
    def my_each
      
      (self.size).times do |n|
        
      end
       
    end
    
end


arr = [1,2,3,4,5,6]

puts arr.my_each {|n| n * 2}
