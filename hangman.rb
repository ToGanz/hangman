module Hangman

  class Game
    attr_reader :word, :filtered_list, :player

    def initialize
      #filtered_list = []
      @player = Player.new
      @filtered_list = load_filter_list
      @word = select_word(@filtered_list)
      @guessed_letters = Array.new(@word.length) {'_'}
      @tries = 0
    end

    def display
      puts "------"
      @guessed_letters.each do |char|
        print "#{char} "
      end
      puts ""
      puts "Tries: #{@tries}"
    end

    def feedback(letter)
      @word.each_with_index do |l, idx|
        if l == letter
          @guessed_letters[idx] = @word[idx]
        end
      end
      @tries += 1
    end

    def game_over?
      if @word == @guessed_letters
        true
      else
        false
      end
    end

    private

    def load_filter_list
      filtered_list = File.open('5desk.txt','r').readlines.select do |line|
        line.length < 13 && line.length > 4
      end
    end

    def select_word(list)
      word = list[rand(list.length-1)].downcase.chomp.split('')
    end

  end

  class Player

    def select_letter
      legit_input = false
      while legit_input == false
        puts "Select a letter!"
        letter = gets.chomp
        if letter.count("a-zA-Z") == 1
          legit_input = true
        end
      end
      letter
    end
  end

end

include Hangman

game = Game.new
print game.word
puts '----'
game.display
while !(game.game_over?) 
  game.feedback(game.player.select_letter)
  game.game_over?
  game.display
  puts '------'
end
puts 'Game over'