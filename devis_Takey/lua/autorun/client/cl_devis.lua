include("cl_recepteur.lua")
local img = Material("devis_envoyeur.png")
local fond = Material("tablet-removebg-preview.png")






surface.CreateFont("wolfix-logs-font-1", {
    font = "Roboto",
    size = 22,
    weight = 1000,
})



local function devis()
    
        local hmenu = vgui.Create("DFrame")
        hmenu:SetSize( 900, 700 )
        hmenu:Center()
        hmenu:SetTitle("")
        hmenu:SetDraggable(false)
        hmenu:MakePopup()
        hmenu:ShowCloseButton(false)
        hmenu.Paint = function(self, w, h)
            
            surface.SetMaterial(fond)
            surface.SetDrawColor( 255, 255, 255, 255)
            surface.DrawTexturedRect(0, 0, 900, 700)
            
        surface.SetMaterial(img)
        surface.SetDrawColor( 255, 255, 255, 255)
        surface.DrawTexturedRect(150, 170, 600, 360)

      
    
        end


        local prix = vgui.Create( "DComboBox", hmenu )
        prix:SetPos(220, 460+10)
        prix:SetSize( 200, 30 )
        prix:SetValue( "" )
        prix:AddChoice( "200" )
        prix:AddChoice( "500" )
        prix:AddChoice( "600" )
        prix:AddChoice( "1000" )
        prix:AddChoice( "1500" )
        prix.OnSelect = function( self, index, value )
            print( value .. " was selected at index " .. index )
        end
        
        
    
        local accident = vgui.Create( "DComboBox", hmenu )
        accident:SetPos(300, 345+30)
        accident:SetSize( 200, 30 )
        accident:SetValue( "" )
        accident:AddChoice( "Accident Volontaire" )
        accident:AddChoice( "Accident Involontaire" )
        accident:AddChoice( "Conduite dangereuse" )
        accident:AddChoice( "Conduite sous produit" )
        accident.OnSelect = function( self, index, value )
            print( value .. " was selected at index " .. index )
        end
        
        


        local close = vgui.Create( "DButton", hmenu ) 
        close:SetText( "" )                          -- Change the Name of Discord Button, by changing the text into : ""   
        close:SetPos(530, 180 )                    
        close:SetSize( 100, 30 ) 
        close:SetDrawBorder(1) 
        close.Paint = function(m, w, h)
            if m:IsHovered() then
                surface.SetDrawColor(Color(20,30,30 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(0,0,0 ,254) )
                draw.SimpleText("Fermer", "wolfix-logs-font-1", w * .5, h * .5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                surface.SetDrawColor(Color(0,0,0 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(20,30,30 ,254) )
                draw.SimpleText("Fermer", "wolfix-logs-font-1", w * .5, h * .5 ,Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
            close.DoClick = function()            

                hmenu:Remove()
        
                surface.PlaySound("buttons/button14.wav")
 
            end
        end


        local DComboBox = vgui.Create( "DComboBox", hmenu )
        DComboBox:SetPos(310, 220+60)
        DComboBox:SetSize( 200, 30 )
        DComboBox:SetValue( "" )
        for k,v in pairs(player.GetAll()) do
            DComboBox:AddChoice(v:Nick(), v)
         end
        DComboBox.OnSelect = function( self, index, value )
            print( value .. " was selected at index " .. index )
        end

        local close = vgui.Create( "DButton", hmenu ) 
        close:SetText( "" )                          
        close:SetPos( 640, 180 )                    
        close:SetSize( 100, 30 ) 
        close:SetDrawBorder(1) 
        close.Paint = function(m, w, h)
            if m:IsHovered() then
                surface.SetDrawColor(Color(20,30,30 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(0,0,0 ,254) )
                draw.SimpleText("Envoyer", "wolfix-logs-font-1", w * .5, h * .5, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            else
                surface.SetDrawColor(Color(0,0,0 ,254))
                draw.RoundedBox( 16, 0,0,w,h, Color(20,30,30 ,254) )
                draw.SimpleText("Envoyer", "wolfix-logs-font-1", w * .5, h * .5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
                      
        end

            close.DoClick = function()

                surface.PlaySound("buttons/button14.wav")

                hmenu:Remove()

                local typeacc = accident:GetSelected()
                local prixacc = prix:GetSelected()
                local targetNick, target = DComboBox:GetSelected() 
                
                net.Start("SubmitOpenFrame")
                  net.WriteString(typeacc)
                  net.WriteString(prixacc)
                  net.WriteEntity(target)
                net.SendToServer()
                

                



            end
            
                
            
        
    end

 

hook.Add( "OnPlayerChat", "devis", function( ply, strText, bTeam, bDead ) 
    if ( ply != LocalPlayer() ) then return end

    strText = string.lower( strText ) 


    if ( strText == "/devis" ) then 
        devis()
        return true 
    end 
end)
 

