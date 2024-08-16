--Variables--
local definedLength = 16
local definedRow = 16

local length = 1
local row = 1
local depth = 1

--Program cycle--
turtle.refuel()
while (true) do
    --Main quarry script--
    if (length < definedLength) then --Go forward--
        turtle.dig()
        turtle.forward()
        length = length + 1
    else
        if (row < definedRow) then   --Move to next row--
            if (row % 2 == 1) then   --Check which way to turn (Zig Zag pattern)--
                if (depth % 2 == 1) then    --Invert if it goes down one level (Diagonal starting position from original starting position)--
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
            else
                if (depth % 2 == 1) then    --Invert if it goes down one level (Diagonal starting position from original starting position)--
                    turtle.turnLeft()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnLeft()
                else
                    turtle.turnRight()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnRight()
                end
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