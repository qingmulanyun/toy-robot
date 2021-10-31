module Constants
    module Robot
        # FACING has to be in this order as a cyclic array to easily represent facing change.
        FACING = [NORTH = 'NORTH',
            EAST = 'EAST',
            SOUTH = 'SOUTH',
            WEST = 'WEST'].freeze

        COMMANDS = [PLACE = 'PLACE',
            MOVE = 'MOVE',
            LEFT = 'LEFT',
            RIGHT = 'RIGHT',
            REPORT = 'REPORT'].freeze
    end
end