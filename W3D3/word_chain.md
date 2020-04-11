The `open-uri` library is built into Ruby. We can create a new set, and then add each word from a dictionary. 

The adjacent words method will loop through the existing word, replacing each consecutive letter with all possible letters from `a..z`. 

```rb
    def adjacent_words(word)
        res = [] 
        (0..word.length-1).each do |idx| 
            ('a'..'z').each do |letter|
                res << word[0...idx] + letter + word[idx+1..-1]
            end
        end 
        adj_words = [] 
        res.each do |word|
            adj_words << word if @dictionary.include?(word)
        end
        adj_words 
    end
```