

require 'open-uri'
require 'set'

class WordChainer 
    def initialize(filename)
        @dictionary = Set.new
        text = open(filename) {|f|
            f.each_line {|line| @dictionary.add(line.chomp) }
        }
    end

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

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}

        until @current_words.empty? 
            @current_words = explore_current_words 
        end
    end

    private 
    def explore_current_words
        new_current_words = [] 
        @current_words.each do |word|
            adjacent_words(word).each do |adj_word| 
                if !@all_seen_words[adj_word]
                    new_current_words << adj_word 
                    @all_seen_words[adj_word] = word 
                end
            end
        end
        new_current_words.each do |word|
            p [word, @all_seen_words[word]]
        end
        new_current_words 
    end
end

wc = WordChainer.new('https://assets.aaonline.io/fullstack/ruby/projects/word_chains/dictionary.txt')
p wc.adjacent_words('cat')
p wc.run('market', 'run')