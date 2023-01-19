local img = Material("devis_envoyeur.png")
local fond = Material("tablet-removebg-preview.png")



net.Receive("EmitOpenFrame", function()
    
    local typeacc = net.ReadString()
    local prixacc = net.ReadString()




    local vmenu = vgui.Create("DFrame")
    vmenu:SetSize( 900, 700 )
    vmenu:Center()
    vmenu:SetTitle("")
    vmenu:SetDraggable(false)
    vmenu:MakePopup()
    vmenu:ShowCloseButton(false)
    vmenu.Paint = function(self, w, h)
        
        surface.SetMaterial(fond)
        surface.SetDrawColor( 255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, 900, 700)
        
        surface.SetMaterial(img)
        surface.SetDrawColor( 255, 255, 255, 255)
        surface.DrawTexturedRect(150, 170, 600, 360)


        draw.SimpleText( typeacc , "wolfix-logs-font-1", 390, 395, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText( prixacc , "wolfix-logs-font-1", 270, 460+25, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText( "Vous" , "wolfix-logs-font-1", 330, 220+75, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        
    
    end

    local close = vgui.Create( "DButton", vmenu ) 
        close:SetText( "" )                          
        close:SetPos( 500, 190 )                    
        close:SetSize( 210, 30 ) 
        close:SetDrawBorder(1) 
        close.Paint = function(m, w, h)
            if m:IsHovered() then
                surface.SetDrawColor(Color(20,30,30 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(0,0,0 ,254) )
                draw.SimpleText("Payer et Fermer", "wolfix-logs-font-1", w * .5, h * .5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                surface.SetDrawColor(Color(0,0,0 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(20,30,30 ,254) )
                draw.SimpleText("Payer et Fermer", "wolfix-logs-font-1", w * .5, h * .5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
                   
                      

            close.DoClick = function()

                vmenu:Remove()

                surface.PlaySound("buttons/button14.wav")

                net.Start("retirer")
                net.WriteString(prixacc)
                net.SendToServer()

            end
        end

end)
    
