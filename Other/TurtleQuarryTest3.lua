--INSTRUCTIONS--
--When placing the turtle down . . .
-- 1) Fuel chest should be on the left side of the turtle.
-- 2) Depo chest should be behind the turtle.
-- 3) Then run the program and let it go.
-- X) Don't forget to chunk load the area the turtle will be in. Be it with a player or other options.

--TO DO LIST--
--Add an if-else for different size areas (in both length and row).
--Turn the travel functions into actual functions (if-for).


--Variables--
local definedLength = 16
local definedRow = 16
 
local length = 1
local row = 1
local depth = 1
 
 
--Get initial fuel setup--
turtle.refuel()
turtle.turnLeft()
turtle.select(1)
turtle.suck()
turtle.refuel()
turtle.turnRight()
 
 
--Start Mining Loop--
print("Start quarry.")
while (true) do --Main quarry script--


    --REFUEL AND INVENTORY DUMP SEQUENCE--
    if ( (turtle.getFuelLevel() <= length + row + depth) or (turtle.getItemCount(16) > 0) ) then --Check fuel level OR Check inventory level--

        --RETURN TO CHEST SUB-SEQUENCE--
        if (depth > 1) then --Return in height to the chest--
            for i=depth,1,-1 do
                turtle.up()
            end
        end

        if (depth % 2 == 1) then    --Return to the chest in row and length based of position (It will choose one of 4 configurations)--

            if (row % 2 == 1) then
                --CONFIGURATION 1--
                turtle.turnLeft()
                if (row > 1) then
                    for i=row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
                if (length > 1) then
                    for i=length,1,-1 do
                        turtle.forward()
                    end
                end
                --###############--
            else
                --CONFIGURATION 2--
                turtle.turnRight()
                if (row > 1) then
                    for i=row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
                if (definedLength - length > 1) then
                    for i=definedLength - length,1,-1 do
                        turtle.forward()
                    end
                end
                --###############--
            end

        else

            if (row % 2 == 1) then
                --CONFIGURATION 3--
                turtle.turnLeft()
                if (definedRow - row > 1) then
                    for i=definedRow - row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
                if (length > 1) then
                    for i=length,1,-1 do
                        turtle.forward()
                    end
                end
                --###############--
            else
                --CONFIGURATION 4--
                turtle.turnRight()
                if (definedRow - row > 1) then
                    for i=definedRow - row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
                if (definedLength - length > 1) then
                    for i=definedLength - length,1,-1 do
                        turtle.forward()
                    end
                end
                --###############--
            end

        end

        --ITEM OFFLOAD AND REFUELLING SUB-SEQUENCE--
        for i=1,16,1 do --Drop all inventory into chest but also consume anything that can be used as fuel--
            turtle.select(i)
            turtle.refuel()
            turtle.drop()
        end
        turtle.turnRight() --Refuel from fuel chest--
        turtle.select(1)
        turtle.suck()
        turtle.refuel()
        turtle.turnRight()


        ----RETURN TO CURRENT MINING LOCATION SUB-SEQUENCE--
        if (depth % 2 == 1) then    --Return to the current mining location in row and length based of position (It will choose one of 4 configurations)--

            if (row % 2 == 1) then
                --CONFIGURATION 1--
                if (length > 1) then
                    for i=length,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                if (row > 1) then
                    for i=row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
                --###############--
            else
                --CONFIGURATION 2--
                if (definedLength - length > 1) then
                    for i=definedLength - length,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                if (row > 1) then
                    for i=row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                
                --###############--
            end

        else

            if (row % 2 == 1) then
                --CONFIGURATION 3--
                if (definedLength - length > 1) then
                    for i=definedLength - length,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                if (definedRow - row > 1) then
                    for i=definedRow - row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnLeft()
               
                --###############--
            else
                --CONFIGURATION 4--
                if (length > 1) then
                    for i=length,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                if (definedRow - row > 1) then
                    for i=definedRow - row,1,-1 do
                        turtle.forward()
                    end
                end
                turtle.turnRight()
                
                --###############--
            end

        end
        
        if (depth > 1) then --Return in height to the chest--
            for i=depth,1,-1 do
                turtle.down()
            end
        end

    end


    --QUARRYING SEQUENCE--
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
        else    --Go down a level--
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