require_relative "playable"

module StudioGame
    class Player
        include Playable 
        attr_accessor :name
        attr_reader :health
        attr_reader :found_treasures
        def initialize(name, health = 100)
            @name = name.capitalize
            @health = health
            @found_treasures = Hash.new(0)
        end

        def name=(new_name)
            @name = new_name.capitalize
        end

        def score
            @health + points 
        end

        def to_s
            "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}"
        end

        def self.from_csv(line)
            name, health = line.split(",")
            Player.new(name, Integer(health))
        rescue ArgumentError
            puts "Ignored invalid health: #{health}"
            Player.new(name)
        end

        def found_treasure(name)
            @found_treasures[name] += 1
        end

        def found_treasure(name, points)
            @found_treasures[name] += points
        end 

        def points
            @found_treasures.values.sum
        end
    end

    if __FILE__ == $0
    player = Player.new("jase")
    puts player.name
    puts player.health
    player.boost
    puts player.health
    player.drain
    puts player.health
    end 
end