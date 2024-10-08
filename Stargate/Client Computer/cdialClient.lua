local SIDES = {
    LEFT = "left",
    RIGHT ="right",
    FRONT = "front",
    BACK = "back",
    BOTTOM = "bottom",
    TOP = "top"
};

--User settings
local MODEM_SIDE = SIDES.TOP;
local REDNET_PROTOCOL = "StargateAddressesComs";
local REDNET_HOSTNAME = "StargateAddressesServer";
local REQUEST_PROTOCOL = "StargateAddressesRequest";
local REPLY_PROTOCOL = "StargateAddressesReply";
local LOCATION_NAME = "CHANGE THIS";

local DETECTION_RANGE = 12;
local CHATBOX_NAME = "&bcSGC";
local CHATBOX_BRACKETS = "[]";
local CHATBOX_COLOUR = "&4";
local CHATBOX_RANGE = 48;

local ADDRESSES = {
    --These are the addresses you want your computer to know in the even that Network addresses cannot be found/used
    --[1] Address Name
    --[2] Address Code
    --[3] Whitelisted Player names (leave empty to allow all)
    {"Abydos", {26, 6, 14, 31, 11, 29, 0} ,{}},
    {"Chulak", {8, 1, 22, 14, 36, 19, 0} ,{}},
    {"Cavum Tenebrae", {18, 7, 3, 36, 25, 15, 0} ,{}},
    {"Lantea", {18, 20, 1, 15, 14, 7, 19, 0} ,{}},
    {"Overworld", {27, 25, 4, 35, 10, 28, 0} ,{}},
    {"Nether", {27, 23, 4, 34, 12, 28, 0} ,{}},
    {"End", {13, 24, 2, 19, 3, 30, 0} ,{}},
    {"Aether", {28, 11, 16, 4, 29, 33, 0} ,{}},
    {"Lost City", {6, 19, 1, 5, 14, 13, 0} ,{}},
    {"Twilight Forest", {7, 26, 9, 25, 2, 20, 0} ,{}},
    {"ATM Mining", {9, 33, 5, 32, 20, 4, 0} ,{}},
    {"ATM Other", {1, 31, 10, 22, 30, 27, 0} ,{}},
    {"ATM Beyond", {4, 35, 31, 7, 34, 13, 0} ,{}},
    {"Alfeim", {21, 8, 36, 25, 32, 28, 0} ,{}},
    {"Undergarden", {37, 26, 21, 30, 19, 12, 0} ,{}},
    {"Everdawn", {34, 25, 27, 3, 11, 38, 0} ,{}},
    {"Everbright", {6, 5, 4, 3, 2, 1, 0} ,{}},
    {"Otherside", {2, 24, 10, 35, 25, 21, 0} ,{}},
    {"Voidscape", {36, 16, 21, 10, 17, 8, 0} ,{}},
    {"Glacio", {26, 20, 4, 36, 9, 27, 0} ,{}},
    {"Blood Magic Dungeon", {14, 16, 2, 18, 6, 33, 0} ,{}},
    {"AE2 Spatial Storage", {7, 10, 34, 12, 19, 21, 0} ,{}},
    {"Reality Marble", {26, 30, 1, 27, 28, 7, 0} ,{}}
};

local INTERFACE_TYPES = {
    BASIC = "basic_interface",
    CRYSTAL = "crystal_interface",
    ADVANCED = "advanced_crystal_interface"
};

local STARGATE_TYPES = {
    CLASSIC = "sgjourney:classic_stargate",
    MILKY_WAY = "sgjourney:milky_way_stargate",
    PEGASUS = "sgjourney:pegasus_stargate",
    UNIVERSE = "sgjourney:universe_stargate",
    TOLLAN = "sgjourney:tollan_stargate"
};

--End of User settings
print("System booting up");
os.sleep(1);

--Open up the modem for communication
rednet.open(MODEM_SIDE);

--Find Advanced Peripherals
local playerDetector = peripheral.find("playerDetector");
if playerDetector == nil then
    error("Player Detector not found", 0);
end
local chatBox = peripheral.find("chatBox");
if chatBox == nil then
    error("Chat Box not found", 0);
end

--Find the proper interface & Stargate Type
print("Checking for \"" .. INTERFACE_TYPES.BASIC .. "\"");
local interfaceType = INTERFACE_TYPES.BASIC;
local interface = peripheral.find(interfaceType);
if interface == nil then
    print("\"" .. INTERFACE_TYPES.BASIC .. "\" was not found attempting to find another\nChecking for \"" .. INTERFACE_TYPES.CRYSTAL .. "\"");
    interfaceType = INTERFACE_TYPES.CRYSTAL;
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES.CRYSTAL .. "\" was not found attempting to find another\nChecking for \"" .. INTERFACE_TYPES.ADVANCED .. "\"");
    interfaceType = INTERFACE_TYPES.ADVANCED;
    interface = peripheral.find(interfaceType);
elseif interface == nil then
    print("\"" .. INTERFACE_TYPES.ADVANCED .. "\" was not found attempting to find another");
    error("No interfaces were found", 0);
end
print("\"" .. interfaceType .. "\" was found");
StargateType = interface.getStargateType();
print("interface Type : " .. interfaceType);
print("Stargate Type : " .. StargateType);

--Local variables & Functions--
local Network_Addresses = nil;
local OldDetectedPlayers = {};
local CurrentDetectedPlayers = {};
local dialSelection = nil;

local function resetStargate()
    interface.disconnectStargate();
    print(interface.getRecentFeedback());
    if interface.isStargateConnected() then
        os.sleep(2.75);
    end
end

local function dialStargate(address, isFastDial)
    local addressLength = #address;

    local addressString = "";
    for i = 1, addressLength, 1 do
        addressString = addressString .. address[i];
        if i ~= addressLength then
            addressString = addressString .. ", ";
        end
    end
    print("Attempting to dial : [" .. addressString .. "]");
    resetStargate();

    if StargateType ~= STARGATE_TYPES.UNIVERSE then
        if addressLength == 8 then
            interface.setChevronConfiguration({1, 2, 3, 4, 6, 7, 8, 5});
        elseif addressLength == 9 then
            interface.setChevronConfiguration({1, 2, 3, 4, 5, 6, 7, 8});
        end
    end

    local start = interface.getChevronsEngaged() + 1;

    if (StargateType == STARGATE_TYPES.MILKY_WAY and isFastDial == false) or (interfaceType == INTERFACE_TYPES.BASIC and STARGATE_TYPES.MILKY_WAY) then
        --Slow dial with ring rotation
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
        --Fast dial with no ring rotation but only slightly delayed light up motion
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

local function clearScreen()
    term.clear();
    term.setCursorPos(1, 1);
end

local function playerFormatedToastJoin(username)
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
        {text = "![dialSelection]", color = "white"},
        {text = " (list dialSelection) to dial gate.", color = "yellow"},

        {text = "\nType ", color = "yellow"},
        {text = "!d", color = "white"},
        {text = " or ", color = "yellow"},
        {text = "!disconnect", color = "white"},
        {text = " to close gate.", color = "yellow"},

        {text = "\nType ", color = "yellow"},
        {text = "!s", color = "white"},
        {text = " or ", color = "yellow"},
        {text = "!sync", color = "white"},
        {text = " to sync network addreses.", color = "yellow"}
    };
    local titleJson = textutils.serialiseJSON(titleMessage);
    local messageJson = textutils.serialiseJSON(joinMessage);
    chatBox.sendFormattedToastToPlayer(messageJson, titleJson, username, CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    os.sleep(0.2);
end

local function playerFormatedToastLeave(username)
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

local function listCommandResponse(username)
    local selectedAddressesList = ADDRESSES;
    local isHardcodedList = "(hardcoded)";
    if Network_Addresses ~= nil and #Network_Addresses ~= 0 then
        selectedAddressesList = Network_Addresses;
        isHardcodedList = "(network)";
    end
    local dialMessage = {};
        dialMessage[1] = {text = "List Below " .. isHardcodedList .. " :\n\n-----", color = "white"};
        dialMessage[2] = {text = "Stargate Destination List", color = "green"};
        dialMessage[3] = {text = "-----", color = "white"};
        local i = 4;
        for j = 1, #selectedAddressesList, 1 do
            dialMessage[i] = {text = "\n[", color = "white"};
            dialMessage[i + 1] = {text = j, color = "orange"};
            dialMessage[i + 2] = {text = "] ", color = "white"};
            dialMessage[i + 3] = {text = selectedAddressesList[j][1], color = "orange"};
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

local function playerNotOnAddressWhitelistResponse(username)
    local message = {
        {text = "You are not allowed to dial this address", color = "red"}
    };
    local messageJson = textutils.serialiseJSON(message);
    chatBox.sendFormattedMessageToPlayer(messageJson, username, CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    os.sleep(0.2);
end

local function checkIfPlayerClose(username)
    for _, v in ipairs(CurrentDetectedPlayers) do
        if v == username then
            return true;
        end
    end
    return false;
end

local function syncRequestNetwordAddresses()
    local lookup_result = rednet.lookup(REDNET_PROTOCOL, REDNET_HOSTNAME);
    if lookup_result ~= nil then
        print("RedNet Network Scanned");
        print("Protocol : " .. REDNET_PROTOCOL);
        print("Hostname : " .. REDNET_HOSTNAME);
        print("Found Host with dialSelection [" .. lookup_result .. "]");

        rednet.send(lookup_result, LOCATION_NAME, REQUEST_PROTOCOL);
        print("Sent message to dialSelection [" .. lookup_result .. "]");
        print("Protocol : " .. REQUEST_PROTOCOL);
        print("Message : " .. LOCATION_NAME);
        return;
    end
    print("Could not find Addresses Server");
    print("Protocol : " .. REDNET_PROTOCOL);
    print("Hostname : " .. REDNET_HOSTNAME);
    print("Switching to hardcoded Addresses");
end

--Main Functions--
local function checkChatEvent()
    local event, username, message, uuid, isHidden = os.pullEvent("chat");
    if checkIfPlayerClose(username) and string.sub(message, 1, 1) == "!" then
        local content = string.sub(message, 2, #message);
        if (content == "l" or content == "list") then
            print("[" .. username .. "] used !list");
            listCommandResponse(username);
            return;
        end
        if (content == "d" or content == "disconnect") then
            print("[" .. username .. "] used !disconnect");
            resetStargate();
            return;
        end
        if (content == "s" or content == "sync") then
            print("[" .. username .. "] used !sync");
            syncRequestNetwordAddresses();
            return;
        end
        local targetId = tonumber(content);
        local selectedAddressesList = ADDRESSES;
        if Network_Addresses ~= nil and #Network_Addresses ~= 0 then
            selectedAddressesList = Network_Addresses;
        end
        if (targetId ~= nil and targetId > 0 and targetId <= #selectedAddressesList) then
            print("[" .. username .. "] selected destination dialSelection : " .. targetId .. "-" .. selectedAddressesList[targetId][1]);
            local addressWhitelist = selectedAddressesList[targetId][3];
            if addressWhitelist ~= nill then
                local isAllowed = false;
                for _, v in ipairs(addressWhitelist) do
                    if v == username then
                        isAllowed = true;
                        break;
                    end
                end
                if not isAllowed then
                    print("Player [" .. username .. "] is not on the whitlist for this address");
                    playerNotOnAddressWhitelistResponse(username);
                    return;
                end
            end
            dialSelection = targetId;
            return;
        end
    end
end

local function checkPlayersCloseByAndNotify()
    CurrentDetectedPlayers = playerDetector.getPlayersInRange(DETECTION_RANGE);
    for _, v1 in ipairs(CurrentDetectedPlayers) do
        local isArrived = true;
        for _, v2 in ipairs(OldDetectedPlayers) do
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

    for _, v1 in ipairs(OldDetectedPlayers) do
        local isGone = true;
        for _, v2 in ipairs(CurrentDetectedPlayers) do
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

    OldDetectedPlayers = CurrentDetectedPlayers;
    os.sleep(0.75);
end

local function checkReceiveNetwordAddresses()
    local senderId, message, protocol = rednet.receive(REPLY_PROTOCOL);
    if protocol == REPLY_PROTOCOL then
        print("Received addresses request from dialSelection [" .. senderId .. "]");
        Network_Addresses = textutils.unserialise(message);
        print("Message table length : [" .. #Network_Addresses .. "]");
        chatBox.sendMessage("Chat Dialer Sync'ed Up", CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
    end
end

--Initial Setup--
clearScreen();
chatBox.sendMessage("Chat Dialer Booting Up", CHATBOX_NAME, CHATBOX_BRACKETS, CHATBOX_COLOUR, CHATBOX_RANGE);
syncRequestNetwordAddresses();
parallel.waitForAny(
    checkReceiveNetwordAddresses,
    function ()
        os.sleep(1.5);
    end
);

--Main Loops--
while(true)
do
    dialSelection = nil;
    while(dialSelection == nil)
    do
        parallel.waitForAny(
            checkReceiveNetwordAddresses,
            checkChatEvent,
            checkPlayersCloseByAndNotify
        );
    end
    if Network_Addresses ~= nil and #Network_Addresses ~= 0 then
        dialStargate(Network_Addresses[dialSelection][2], true);
    else
        dialStargate(ADDRESSES[dialSelection][2], true);
    end
end