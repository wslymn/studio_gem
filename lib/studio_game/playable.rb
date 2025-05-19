module StudioGame
    module Playable 
        def drain
            @health -= 10
        end

        def boost
            @health += 15
        end
    end
end