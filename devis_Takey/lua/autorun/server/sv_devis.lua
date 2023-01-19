util.AddNetworkString("SubmitOpenFrame")
util.AddNetworkString("retirer")
util.AddNetworkString("EmitOpenFrame")


net.Receive("SubmitOpenFrame", function(len, emiter)
    local typeacc = net.ReadString()
    local prixacc = net.ReadString()
    local target = net.ReadEntity()

    if (IsValid(target) and target:IsPlayer()) then
       -- if (emiter == target) then return end // BLOQUE LE PROCESSUS SI LE JOUEUR SELECTIONNE EST LE JOUEUR QUI SELECTIONNE

        -- TODO: Anti spam protector
        net.Start("EmitOpenFrame")
        net.WriteString(typeacc )
        net.WriteString(prixacc )
        net.Send(target)
    end

    
    


end)


net.Receive("retirer", function(len, ply)
    local prixacc = net.ReadString()
    ply:addMoney(-tonumber(prixacc))
end)




