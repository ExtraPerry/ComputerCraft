local SIDES = {
    LEFT = "left",
    RIGHT ="right",
    FRONT = "front",
    BACK = "back",
    BOTTOM = "bottom",
    TOP = "top"
};

local MODEM_SIDE = SIDES.TOP;
local REDNET_PROTOCOL = "StargateAddressesComs";
local REDNET_HOSTNAME = "StargateAddressesServer";
local REQUEST_PROTOCOL = "StargateAddressesRequest";
local REPLY_PROTOCOL = "StargateAddressesReply";

local ADDRESSES = {
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
    {"Reality Marble", {26, 30, 1, 27, 28, 7, 0} ,{}},
    --Private Server Stuff (Custom Addresses)--
    {"Chulak Base", {18, 11, 28, 26, 24, 35, 9, 25, 0} ,{}},
    {"Spawn", {30, 17, 27, 28, 14, 25, 20, 2, 0} ,{}},
    {"Shama's old Home", {21, 9, 4, 25, 30, 8, 15, 26, 0} ,{}},
    {"Ancient City", {21, 15, 24, 25, 34, 26, 11, 28, 0} ,{}}
};

function clearScreen()
    term.clear();
    term.setCursorPos(1, 1);
end
clearScreen();

rednet.open(MODEM_SIDE);
rednet.host(REDNET_PROTOCOL, REDNET_HOSTNAME);
print("RedNet Network Opened");
print("Protocol : " .. REDNET_PROTOCOL);
print("Hostname : " .. REDNET_HOSTNAME);

while true do
    local senderId, message, protocol = rednet.receive(REQUEST_PROTOCOL);
    if protocol == REQUEST_PROTOCOL then
        print("Received addresses request from ID [" .. senderId .. "]");
        print("Message : " .. message);

        local addresses = textutils.serialise(ADDRESSES);
        rednet.send(senderId, addresses, REPLY_PROTOCOL);
        print("Sent address list back to ID [" .. senderId .. "]");
        print("Protocol : " .. REPLY_PROTOCOL);
        print("Message table length : [" .. #ADDRESSES .. "]");
    end
end