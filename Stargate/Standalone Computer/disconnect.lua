interface = peripheral.find("crystal_interface")
interface.disconnectStargate();
print(interface.getRecentFeedback());
if interface.isStargateConnected() then
    os.sleep(2.75);
end