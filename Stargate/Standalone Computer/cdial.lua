--Global Static Variables--
DETECTION_RANGE = 8;
CHATBOX_NAME = "&bcSGC";
CHATBOX_BRACKETS = "[]";
CHATBOX_COLOUR = "&4";
CHATBOX_RANGE = 48;

ADDRESSES = {
    {"Abydos", {26, 6, 14, 31, 11, 29, 0}},
    {"Chulak", {8, 1, 22, 14, 36, 19, 0}},
    {"Cavum Tenebrae", {18, 7, 3, 36, 25, 15, 0}},
    {"Lantea", {18, 20, 1, 15, 14, 7, 19, 0}},
    {"Overworld", {27, 25, 4, 35, 10, 28, 0}},
    {"Nether", {27, 23, 4, 34, 12, 28, 0}},
    {"End", {13, 24, 2, 19, 3, 30, 0}},
    {"Aether", {28, 11, 16, 4, 29, 33, 0}},
    {"Twilight Forest", {36, 33, 16, 25, 7, 14, 0}},
    {"Lost City", {13, 4, 27, 8, 19, 3, 0}},
    {"Glacio", {26, 20, 4, 36, 9, 27, 0}},
    {"ATM Mining", {25, 33, 20, 7, 37, 17, 0}},
    {"ATM Other", {12, 23, 36, 13, 21, 16, 0}},
    {"ATM Beyond", {27, 5, 2, 23, 17, 38, 0}},
    {"Alfeim", {4, 9, 13, 11, 20, 7, 0}},
    {"Everbright", {24, 23, 37, 26, 35, 12, 0}},
    {"Everdawn", {5, 7, 10, 16, 26, 21, 0}},
    {"Otherside", {4, 13, 27, 12, 24, 17, 0}},
    {"Undergarden", {2, 4, 6, 31, 21, 35, 0}},
    {"Voidscape", {26, 5, 4, 11, 2, 37, 0}},
    --Private Server Stuff (Custom Addresses)--
    {"Chulak Base", {18, 11, 28, 26, 24, 35, 9, 25, 0}},
    {"Spawn", {30, 17, 27, 28, 14, 25, 20, 2, 0}},
    {"Shama's old Home", {21, 9, 4, 25, 30, 8, 15, 26, 0}},
    {"Ancient City", {21, 15, 24, 25, 34, 26, 11, 28, 0}}
};

INTERFACE_TYPES = {
    "basic_interface",
    "crystal_interface",
    "advanced_crystal_interface"
};

STARGATE_TYPES = {
    "sgjourney:classic_stargate",
    "sgjourney:milky_way_stargate",
    "sgjourney:pegasus_stargate",
    "sgjourney:universe_stargate",
    "sgjourney:tollan_stargate"
};

--Find Advanced Peripherals--
local playerDetector = peripheral.find("playerDetector");
if playerDetector == nil then 
    error("Player Detector not found", 0) 
end
local chatBox = peripheral.find("chatBox");
if chatBox == nil then 
    error("Chat Box not found", 0) 
end

--Find the proper interface & Stargate Type--
print("Checking for \"" .. INTERFACE_TYPES[1] .. "\"");
interfaceType = INTERFACE_TYPES[1];
interface = peripheral.find(interfaceType);
if interface == nil then
    print("\"" .. INTERFACE_TYPES[1] .. "\" was not found attempting to find another");
    print("Checking for \"" .. INTERFACE_TYPES[2] .. "\"");
    interfaceType = INTERFACE_TYPES[2];
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES[2] .. "\" was not found attempting to find another");
    print("Checking for \"" .. INTERFACE_TYPES[3] .. "\"");
    interfaceType = INTERFACE_TYPES[3];
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES[3] .. "\" was not found attempting to find another");
    error("No interfaces were found", 0);
end
print("\"" .. interfaceType .. "\" was found");
StargateType = interface.getStargateType();
print("interface Type : " .. interfaceType);
print("Stargate Type : " .. StargateType);

--Global variables & Functions--
oldDetectedPlayers = {};
currentDetectedPlayers = {};
local id = nil;

function resetStargate()
    interface.disconnectStargate();
    print(interface.getRecentFeedback());
    if interface.isStargateConnected() then
        os.sleep(2.75);
    end
end

function dialStargate(address, isFastDial)
    local addressLength = #address;

    addressString = "";
    for i = 1, addressLength, 1 do
        addressString = addressString .. address[i];
        if i ~= addresselength then
            addressString = addressString .. ", ";
        end
    end
    print("Attempting to dial : [" .. addressString .. "]");
    resetStargate();
    
    if StargateType ~= STARGATE_TYPES[4] then
        if addressLength == 8 then
            interface.setChevronConfiguration({1, 2, 3, 4, 6, 7, 8, 5});
        elseif addressLength == 9 then
            interface.setChevronConfiguration({1, 2, 3, 4, 5, 6, 7, 8});
        end
    end
 
    local start = interface.getChevronsEngaged() + 1;
 
    if StargateType == STARGATE_TYPES[2] and isFastDial == false then
        for chevron = start,addressLength,1
        do
            local symbol = address[chevron];
 
            if chevron % 2 == 0 then
                interface.rotateClockwise(symbol);
            else
                interface.rotateAntiClockwise(symbol);
            end
 
            while(not interface.isCurrentSymbol(symbol))
            do
                os.sleep(0);
            end
 
            interface.endRotation();
 
            os.sleep(1);
            interface.openChevron();
 
            os.sleep(0.5);
            interface.closeChevron();
            print("Chevron[" .. chevron .. "] Engaged !!!");
            sleep(1);
        end
    else
        for chevron = start,addressLength,1
        do
            local symbol = address[chevron];
            interface.engageSymbol(symbol);
            print("Chevron[" .. chevron .. "] Engaged !!!");
            os.sleep(0.15);
        end
        print(interface.getRecentFeedback());
    end
end

function clearScreen()
    term.clear();
    term.setCursorPos(1, 1);
end

function playerFormatedToastJoin(username)
    local titleMessage = {
        {text = "Notification", color = "yellow"}
    };
    local joinMessage = {
        {text = "You've entered Chat activation range for this Stargate.", color = "green"},

        {text = "\nType ", color = "yellow"},
        {text = "!l", color = "white"},
        {text = " or ", color = "yellow"},
        {text = "!list", color = "white"},
        {text = " to view destination ids.", color = "yellow"},

        {text = "\nType ", color = "yellow"},
        {text = "![id]", color = "white"},
        {text = " (list id) to dial gate.", color = "yellow"},

        {text = "\nType ", color = "yellow"},
        {text = "!d", color = "white"},
        {text = " or ", color = "yellow"},
        {text = "!disconnect", color = "white"},
        {text = " to close gate.", color = "yellow"}
    };
    local titleJson = textutils.serialiseJSON(titleMessage);
    local messageJson = textutils.serialiseJSON(joinMessage);
    chatBox.sendFormattedToastToPlayer(messageJson, titleJson, username, CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    os.sleep(0.2);
end

function playerFormatedToastLeave(username)
    local titleMessage = {
        {text = "Notification", color = "yellow"}
    };
    local leaveMessage = {
        {text = "You've left Chat activation range for this Stargate.", color = "red"}
    };
    local titleJson = textutils.serialiseJSON(titleMessage);
    local messageJson = textutils.serialiseJSON(leaveMessage);
    chatBox.sendFormattedToastToPlayer(messageJson, titleJson, username, CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    os.sleep(0.2);
end

function dialCommandResponse(username)
    local dialMessage = {};
        dialMessage[1] = {text = "List Below :\n\n-----", color = "white"};
        dialMessage[2] = {text = "Stargate Destination List", color = "green"};
        dialMessage[3] = {text = "-----", color = "white"};
        local i = 4;
        for j = 1, #ADDRESSES, 1 do
            dialMessage[i] = {text = "\n[", color = white};
            dialMessage[i + 1] = {text = j, color = orange};
            dialMessage[i + 2] = {text = "] ", color = white};
            dialMessage[i + 3] = {text = ADDRESSES[j][1], color = orange};
            i = i + 4;
        end
        local dilaMessageLength = #dialMessage;
        dialMessage[dilaMessageLength + 1] = {text = "\n-----------Enter-", color = "white"};
        dialMessage[dilaMessageLength + 2] = {text = "!number", color = "red"};
        dialMessage[dilaMessageLength + 3] = {text = "-----------", color = "white"};
    local messageJson = textutils.serialiseJSON(dialMessage);
    chatBox.sendFormattedMessageToPlayer(messageJson, username, CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    os.sleep(0.2);
end

function checkIfPlayerClose(username)
    for _, v in ipairs(currentDetectedPlayers) do
        if v == username then
            return true;
        end
    end
    return fasle;
end

--Main Functions--
function checkChatEvent()
    local event, username, message, uuid, isHidden = os.pullEvent("chat");
    if checkIfPlayerClose(username) and string.sub(message, 1, 1) == "!" then
        local content = string.sub(message, 2, #message);
        if (content == "l" or content == "list") then
            print("[" .. username .. "] used !dial");
            dialCommandResponse(username);
        end
        if (content == "d" or content == "disconnect") then
            print("[" .. username .. "] used !disconnect");
            resetStargate();
        end
        local targetId = tonumber(content);
        if (targetId ~= nil and targetId > 0 and targetId <= #ADDRESSES) then
            print("[" .. username .. "] selected destination id : " .. targetId .. "-" .. ADDRESSES[targetId][1]);
            id = targetId;
        end
    end
end

function checkPlayersCloseByAndNotify()
    currentDetectedPlayers = playerDetector.getPlayersInRange(DETECTION_RANGE);
    for k1, v1 in ipairs(currentDetectedPlayers) do
        isArrived = true;
        for k2, v2 in ipairs(oldDetectedPlayers) do
            if v1 == v2 then
                isArrived = false;
                break;
            end
        end
        if isArrived then
            print("[" .. v1 .. "] joined");
            playerFormatedToastJoin(v1);
        end
    end

    for k1, v1 in ipairs(oldDetectedPlayers) do
        isGone = true;
        for k2, v2 in ipairs(currentDetectedPlayers) do
            if v1 == v2 then
                isGone = false;
                break;
            end
        end
        if isGone then
            print("[" .. v1 .. "] left");
            playerFormatedToastLeave(v1);
        end
    end
    
    oldDetectedPlayers = currentDetectedPlayers;
    os.sleep(0.75);
end

--Main Loops--
chatBox.sendMessage("Chat Dialer Booting Up", CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
clearScreen();
while(true)
do
    id = nil;
    while(id == nil)
    do
        parallel.waitForAny(checkChatEvent, checkPlayersCloseByAndNotify);
    end
    dialStargate(ADDRESSES[id][2], true);
end