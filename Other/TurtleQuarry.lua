```lua

--Variables--
local definedLength = 16
local definedRow = 16

local length = 1
local row = 1
local depth = 1

--Program cycle--
while (true) do

    --Fuel ressuply checker and return function--
    if (turtle.getFuelLevel() <= length + row + depth) then
            print("Fuel low returning to chest.")

            --------------------------------------------------
            while ( (length not 1) and (row not 1) and (depth not 1) ) do  --Return to chest--
                for i = depth,1,-1 do
                    turtle.up()
                end
        
                for i = row,1,-1 do 
                    turtle.up()
                end
        
                for i = length,1,-1 do 
                    turtle.up()
                end
                print("Arrived at Chest")
            end
            --------------------------------------------------
    end

    --Main quarry script--
    if (length < definedLength) then --Go forward--
        turtle.forward()
        length = length + 1
    else
        if (row < definedRow) then   --Move to next row--
            if (row % 2 == 1) then   --Check which way to turn (Zig Zag pattern)--
                turtle.turnRight()
                turtle.dig()
                turtle.forward()
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.dig()
                turtle.forward()
                turtle.turnLeft()
            end
            length = 1
            row = row + 1
        else
            turtle.turnRight()
            turtle.turnRight()
            turtle.digDown()
            turtle.down()
            length = 1
            row = 1
            depth = depth + 1
        end
    end
end
```