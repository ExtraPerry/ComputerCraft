--Variables--
local definedLength = 16
local definedRow = 16
 
local length = 1
local row = 1
local depth = 1
 
 
--Get initial fuel setup--
turtle.refuel()
turtle.turnLeft()
turtle.turnLeft()
turtle.select(1)
turtle.suck()
turtle.refuel()
turtle.turnLeft()
turtle.turnLeft()
 
 
--Start Mining Loop--
print("Start quarry.")
while (true) do --Main quarry script--
    
 
    --FUEL & INVENTORY CHECK--
    if ( (turtle.getFuelLevel() <= length + row + depth) or (turtle.getItemCount(16) > 0) ) then --Check fuel level OR Check inventory level--
        print("Fuel low OR Inventory full.")
 
 
        --RETURN TO CHEST LOGIC--
        if (depth % 2 == 1) then --Chest : Bottom Left | Origin : Bottom Left--
 
            if (row % 2 == 1) then  --Chest : Bottom Left | Origin : Bottom Left | Direction : Away from origin--
                turtle.turnRight()  --Turn arround--
                turtle.turnRight()
                if (length > 1) then
                    for i=length,1,-1 do    --Return towards the chest length wise--
                        turtle.dig()
                        turtle.forward()
                    end
                end
            else    --Chest : Bottom Left | Origin : Bottom Left | Direction : Towards origin--
                if (definedLength - length > 1) then
                    for i=(definedLength - length),1,-1 do    --Return towards the chest length wise--
                        turtle.dig()
                        turtle.forward()
                    end
                end
            end
 
            turtle.turnRight()
            if (row > 1) then
                for i=row,1,-1 do   --Return towards the chest across rows--
                    turtle.dig()
                    turtle.forward()
                end
            end
 
        else    --Chest : Bottom Left | Origin : Top Right--
 
            if (row % 2 == 1) then  --Chest : Bottom Left | Origin : Top Right | Direction : Away from origin--
                if (definedLength - length > 1) then
                    for i=(definedLength - length),1,-1 do    --Return towards the chest length wise--
                        turtle.dig()
                        turtle.forward()
                    end
                end
            else    --Chest : Bottom Left | Origin : Top Right | Direction : Towards origin--
                turtle.turnRight()  --Turn arround--
                turtle.turnRight()
                if (length > 1) then
                    for i=length,1,-1 do    --Return towards the chest length wise--
                        turtle.dig()
                        turtle.forward()
                    end
                end
            end
 
            turtle.turnRight()
            if (definedRow - row > 1) then
                for i=(definedRow - row),1,-1 do   --Return towards the chest across rows--
                    turtle.dig()
                    turtle.forward()
                end
            end
 
        end
 
        if (depth > 1) then
            for i=depth,1,-1 do   --Return towards the chest in height--
                turtle.digUp()
                turtle.up()
            end
        end
 
        
        --ITEM OFFLOAD AND REFUELLING--
        for i=1,16,1 do --Drop all inventory into chest but also consume anything that can be used as fuel--
            turtle.select(i)
            turtle.refuel()
            turtle.drop()
        end
        turtle.turnLeft() --Refuel from fuel chest--
        turtle.select(1)
        turtle.suck()
        turtle.refuel()
 
 
        --RETURN TO MINING LOCATION--
        turtle.turnLeft()
        if (depth % 2 == 1) then
            if (row > 1) then
                for i=row,1,-1 do   --Return to mining position across rows--
                    turtle.dig()
                    turtle.forward()
                end
            end
 
            turtle.turnLeft()
            if (row % 2 == 1) then
                if (length > 1) then
                    for i=length,1,-1 do    --Return to mining position across length-
                        turtle.dig()
                        turtle.forward()
                    end
                end
            else
                if (definedLength - length > 1) then
                    for i=(definedLength - length),1,-1 do    --Return to mining position across length-
                        turtle.dig()
                        turtle.forward()
                    end
                end
                turtle.turnRight()  --Turn arround--
                turtle.turnRight()
            end
        else
            if (definedRow - row > 1) then
                for i=(definedRow - row),1,-1 do   --Return to mining position across rows--
                    turtle.dig()
                    turtle.forward()
                end
            end
 
            if (row % 2 == 1) then
                if (definedLength - length > 1) then
                    for i=(definedLength - length),1,-1 do    --Return to mining position across length-
                        turtle.dig()
                        turtle.forward()
                    end
                end
 
                turtle.turnRight()  --Turn arround--
                turtle.turnRight()
            else
                if (length > 1) then
                    for i=length,1,-1 do    --Return to mining position across length-
                        turtle.dig()
                        turtle.forward()
                    end
                end
            end
        end
 
        if (depth > 1) then
            for i=depth,1,-1 do   --Return to mining position in depth--
                turtle.digDown()
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