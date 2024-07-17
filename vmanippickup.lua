
local PLUGIN = PLUGIN

PLUGIN.name = "ItemPickupAnimation"
PLUGIN.author = "arigato"
PLUGIN.description = "Plays a pickup animation when picking up items."

if (SERVER) then
    util.AddNetworkString("PlayPickupAnimation")

    function PLUGIN:PlayerInteractItem(client, action, item)
        if action == "take" then
            net.Start("PlayPickupAnimation")
            net.WriteString(item.uniqueID)
            net.Send(client)
        end
    end
else
    net.Receive("PlayPickupAnimation", function()
        local itemID = net.ReadString()
        if itemID and VManip and VManip.PlayAnim then
            VManip:PlayAnim("interactslower")
        end
    end)
end
