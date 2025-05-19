require_relative "treasure_trove"
require_relative "auditable"

module StudioGame
    class Game
        attr_reader :title, :players
        include Auditable
        def initialize(title)
            @title = title
            @players = [] 
        end

        def load_players(from_file)
            File.readlines(from_file, chomp: true).each do |line|
                player = Player.from_csv(line)
                add_player(player)
            end
            rescue Errno::ENOENT
                puts "File not found: #{from_file}"
                exit 1
            end 

        def add_player(player)
            @players << player
        end

        def play(rounds = 1)
            
            puts "\nLet's play #{@title}."
            
            puts "The following treasures can be found:"
            TreasureTrove::TREASURES.each do |treasure|
                puts "A #{treasure.name} is worth #{treasure.points} points"
            end
            
            puts "\nBefore playing:"
            puts @players
            
            1.upto(rounds) do |round|
                puts "\nRound #{round}: "
        
                @players.each do |player|
                    number_rolled = roll_die    
                    
                    case number_rolled 
                    when 1..2 
                        player.drain
                        puts "#{player.name} got drained"
                    when 3..4
                        puts "#{player.name} got skipped"
                    else
                        puts "#{player.name} got boosted"
                        player.boost
                    end
                    treasure = TreasureTrove.random_treasure
                    
                    player.found_treasure(treasure.name, treasure.points)
                    puts "#{player.name} found a #{treasure.name} worth #{treasure.points} points"
                end
            end
        end
        
        def roll_die
            number = rand(1..6)
            audit(number)
        end
        
        def sorted_players
            @players.sort_by { |player| player.score }.reverse
        end

        def print_stats
            puts "\n#{@title} Statistics"
            puts "-" * 30
            puts sorted_players

            @players.each do |player|
                puts "\n#{player.name}'s treasure point totals:"
                player.found_treasures.each do |name, points|
                    puts "#{name}: #{points}"
                end
                puts "-" * 15
                puts "total: #{player.points}"
            end
        end

        def high_scores
            puts "\nHigh Scores:" 
            sorted_players.each do |player|
            name = player.name.ljust(20, ".")
            points = player.score.round.to_s.rjust(5)
            puts "#{name}#{points}"
            end
        end

        def save_high_scores(to_file = "high_scores.txt")
            File.open(to_file, "w") do |file|
                file.puts "#{title} High Scores:"
                file.puts "\nHigh Scores:" 
                sorted_players.each do |player|
                    name = player.name.ljust(20, ".")
                    points = player.score.round.to_s.rjust(5)
                    file.puts "#{name}#{points}"
                end
            end
        end
    end 
end