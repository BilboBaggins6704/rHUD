scoreboard = scoreboard or {}

include("autorun/rscoreboard_config.lua")
local config = RScoreboard

if config.ScoreboardEnabaled == true then
	function scoreboard:show()
		if !IsValid(RScoreboard) then
			RScoreboard = vgui.Create( "DFrame" )
			RScoreboard:SetSize( 420, 750 )
			RScoreboard:Center()
			RScoreboard:SetAlpha( 0 )
			RScoreboard:AlphaTo(255, 0.5, 0)
			RScoreboard:SetTitle( "" )
			RScoreboard:SetDraggable( true )
			RScoreboard:ShowCloseButton( false )
			RScoreboard.Paint = function(self)
			
				// Genral.
			
				draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), config.MainColor )
				
				draw.RoundedBox( 0, 0, 85, self:GetWide(), 25, config.MainBars )
				
				draw.RoundedBox( 0, 0, 0, self:GetWide(), 25, config.MainBars )
				
				draw.DrawText( GetHostName(), "PlayerFont", 10, 5, config.HostName )
				
				draw.DrawText( "PLAYERS ONLINE : " .. #player.GetAll(), "PlayerFont", 10, 89, config.Players, TEXT_ALIGN_LEFT )
				
				draw.DrawText( LocalPlayer():GetName(), "PlayerFont", 50, 36, config.YourName )
				
				draw.DrawText( LocalPlayer():getDarkRPVar("job"), "PlayerFont", 50, 51, config.YourJob )
				
				draw.DrawText( "Wallet: " .. DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "PlayerFont", RScoreboard:GetWide() - 30, 36, config.YourMoney, TEXT_ALIGN_RIGHT )
							
				// Settings Icon
				
				surface.SetDrawColor( 255, 255, 255, 255 ) 
				surface.SetMaterial( Material( "icon16/wrench.png" ) )
				surface.DrawTexturedRect( RScoreboard:GetWide() - 30, 65, 16, 16 ) 

			end
			
			RTheme = vgui.Create( "DButton", RScoreboard )
			RTheme:SetSize( 16, 16 )
			RTheme:SetPos( RScoreboard:GetWide() - 30, 65 )
			RTheme:SetText( "" )
			RTheme.Paint = function(self)
				draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ) )
			end
			RTheme.DoClick = function()
				local RMenu = vgui.Create( "DMenu" )
				RMenu:Open( gui.MouseX(), gui.MouseY() )
				RMenu.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
				end
				
				local NameMenu = RMenu:AddSubMenu( "RolePlay" )
				NameMenu:AddOption( "Change RP Name", function()

					RScoreboard:Remove()
				
					local RPNameBox = vgui.Create( "DFrame" )
					RPNameBox:SetSize( 400, 300 )
					RPNameBox:Center()
					RPNameBox:MakePopup()
					RPNameBox:SetTitle( "" )
					RPNameBox:ShowCloseButton( false )
					RPNameBox.Paint = function(self)
						draw.RoundedBox( 5, 0, 0, self:GetWide(), self:GetTall(), Color( 33, 33, 33 ) )
						draw.DrawText( "ROLEPLAY NAME", "RPNAME", self:GetWide() / 2, 45, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
					end
					
					local RPNameEntry = vgui.Create( "DTextEntry", RPNameBox )
					RPNameEntry:SetSize( 200, 20 )
					RPNameEntry:Center()
					RPNameEntry:SetDrawBackground( true )
					RPNameEntry:SetDrawBorder( true )
					RPNameEntry:SetTextColor( Color( 0, 0, 0) )
					RPNameEntry:SetText( LocalPlayer():GetName() )
					
					local RPNameConfirm = vgui.Create( "DButton", RPNameBox )
					RPNameConfirm:SetSize( 200, 60 )
					RPNameConfirm:SetPos( RPNameBox:GetWide() / 2 - 100, 180 )
					RPNameConfirm:SetText( "" )
					RPNameConfirm.Paint = function(self)
						draw.RoundedBox( 5, 0, 0, self:GetWide(), self:GetTall(), Color( 66, 66, 66 ) )
						draw.DrawText( "CONFIRM", "CONFIRM", self:GetWide() / 2, 17, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
					end
					RPNameConfirm.DoClick = function()
						RunConsoleCommand( "say", "/rpname " .. RPNameEntry:GetValue() )
						RPNameBox:Remove()
					end
					
				end )
				NameMenu.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
				end
				
				RMenu:AddSpacer()
				
				local Themes = RMenu:AddSubMenu( "Steam" )
				Themes:AddOption( "Steam Profile", function()

					LocalPlayer():ShowProfile()
					
				end	)
				Themes.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
				end
				Themes.DoClick = function()

				end
				
				RMenu:AddSpacer()
				
				local Disconnect = RMenu:AddSubMenu( "Game Options" )
				if config.EnableReconnect == true then
					Disconnect:AddOption( "Re-Connect", function() RunConsoleCommand( "retry" ) end )
				end
				if config.EnableDisconnect == true then
					Disconnect:AddOption( "Disconnect", function() RunConsoleCommand( "disconnect" ) end )
				end
				Disconnect.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
				end
							
			end
			
			for k, v in pairs(player.GetAll()) do
			
				local RMember = vgui.Create( "AvatarImage", RScoreboard )
				RMember:SetSize( 36, 36 )
				RMember:SetPos( 10, 36 )
				RMember:SetPlayer( LocalPlayer(), 36 )
						
			end
			
			local RScrollPanel = vgui.Create( "DScrollPanel", RScoreboard )
			RScrollPanel:SetSize( RScoreboard:GetWide(), RScoreboard:GetTall() - 60 )
			RScrollPanel:SetPos( 0, 110 )
			
			local sbar = RScrollPanel:GetVBar()
			function sbar:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
			end
			function sbar.btnUp:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 66, 66, 66 ) )
			end
			function sbar.btnDown:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 66, 66, 66 ) )
			end
			function sbar.btnGrip:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 66, 66, 66 ) )
			end

		function RScrollPanel:OnScrollbarAppear() return true end
			
			RList = vgui.Create( "DListLayout", RScrollPanel )
			RList:SetSize( RScrollPanel:GetWide(), RScrollPanel:GetTall() )
			RList:SetPos( 0, 0 )
			
			
		end
		
		if IsValid(RScoreboard) then
			RList:Clear()
			
			for k, v in pairs(player.GetAll()) do
			
				local RPanel = vgui.Create( "DPanel", RList )
				RPanel:SetSize( RList:GetWide(), 50 )
				RPanel:SetPos( 0, 0 )
				RPanel.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), config.MainColor )
					draw.RoundedBox( 0, 0, 49, self:GetWide(), 1, config.PlayersLine )
					
					draw.DrawText( v:GetName(), "PlayerFont", 50, 5, config.MainText )
					
					draw.DrawText( v:getDarkRPVar("job"), "PlayerFont", 50, 20, team.GetColor(v:Team()) )
					
					draw.DrawText( "Kills: " .. v:Frags(), "PlayerFont", RList:GetWide() - 30, 5, config.MainText, TEXT_ALIGN_RIGHT )
					draw.DrawText( "Deaths: " .. v:Deaths(), "PlayerFont", RList:GetWide() - 30, 20, config.MainText, TEXT_ALIGN_RIGHT )
					
					// Icon
					
					surface.SetDrawColor( 255, 255, 255, 255 ) 
					surface.SetMaterial( Material( "icon16/user_go.png" ) )
					surface.DrawTexturedRect( RPanel:GetWide() - 30, 30, 16, 16 ) 
					
				end
				
				local RInfo = vgui.Create( "DButton", RPanel )
				RInfo:SetSize( 16, 16 )
				RInfo:SetPos( RPanel:GetWide() - 28, 30 )
				RInfo:SetText( "" )
				RInfo.Paint = function(self)
					draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ) )
				end
				RInfo.DoClick = function()
					local PlayerInfo = vgui.Create( "DMenu" )
					PlayerInfo:Open( gui.MouseX(), gui.MouseY() )
					PlayerInfo.Paint = function(self)
						draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
					end
					
					local SteamOptions = PlayerInfo:AddSubMenu( "Steam" )
					SteamOptions:AddOption( "Steam Profile", function() v:ShowProfile() end )
					SteamOptions.Paint = function(self)
						draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
					end
					
					local PlayerOptions = PlayerInfo:AddSubMenu( "Player Information" )
					PlayerOptions:AddOption( "Copy SteamID", function() SetClipboardText( v:SteamID() ) v:ChatPrint( "You just copied " .. v:GetName() .. "'s SteamID." ) end )
					PlayerOptions:AddOption( "Copy Name", function() SetClipboardText( v:GetName() ) v:ChatPrint( "You just copied " .. v:GetName() .. "'s name." ) end )
					PlayerOptions:AddOption( "Copy Name and SteamID", function() SetClipboardText( v:GetName() .. "  " .. v:SteamID() ) v:ChatPrint( "You just copied " .. v:GetName() .. "'s name and SteamID." ) end ) 
					PlayerOptions.Paint = function(self)
						draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
					end
					
					local PlayerRP = PlayerInfo:AddSubMenu( "RolePlay Information" )
					PlayerRP:AddOption( "Copy Job Name", function() SetClipboardText( v:getDarkRPVar("job") ) v:ChatPrint( "You just copied " .. v:GetName() .. "'s job title." ) end )
					PlayerRP.Paint = function(self)
						draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
					end
					
						if table.HasValue( config.ADMIN, LocalPlayer():GetUserGroup()) then
							local AdminRP = PlayerInfo:AddSubMenu( "Admin" )
							AdminRP:AddOption( "Goto", function()
							
							if config.ULX == true then
								RunConsoleCommand( "ulx", "goto", v:Nick() )
							end
							
							if config.FADMIN == true then
								RunConsoleCommand( "_FAdmin", "goto", v:Nick() )
							end
										
							end	)
							AdminRP:AddOption( "Bring", function()
							
							if config.ULX == true then
								RunConsoleCommand( "ulx", "bring", v:Nick() )
							end
							
							if config.FADMIN == true then
								RunConsoleCommand( "_FAdmin", "bring", v:Nick() )
							end
								
							end )
							AdminRP:AddOption( "Freeze", function()
							
							if config.ULX == true then
								RunConsoleCommand( "ulx", "freeze", v:Nick() )
							end
							
							if config.FADMIN == true then
								RunConsoleCommand( "_FAdmin", "freeze", v:Nick() )
							end
								
							end )
							AdminRP:AddOption( "Jail", function()
							
							if config.ULX == true then
								RunConsoleCommand( "ulx", "jail", v:Nick() )
							end
							
							if config.FADMIN == true then
								RunConsoleCommand( "_FAdmin", "jail", v:Nick(), "normal" )
							end
								
							end )
							if config.ULX == true then
								AdminRP:AddOption( "Jail TP", function(self)
								
								RunConsoleCommand( "ulx", "jailtp", v:Nick() )
									
								end )
							end
							AdminRP:AddOption( "Kick", function()
							
								local KickBox = vgui.Create( "DFrame" )
								KickBox:SetSize( 400, 300 )
								KickBox:Center()
								KickBox:MakePopup()
								KickBox:SetTitle( "" )
								KickBox:ShowCloseButton( false )
								KickBox.Paint = function(self)
									draw.RoundedBox( 5, 0, 0, self:GetWide(), self:GetTall(), Color( 33, 33, 33 ) )
									draw.DrawText( "KICK REASON", "RPNAME", self:GetWide() / 2, 45, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
									
									surface.SetDrawColor( 255, 255, 255, 255 ) 
									surface.SetMaterial( Material( "icon16/cancel.png" ) )
									surface.DrawTexturedRect( KickBox:GetWide() - 20, 5, 16, 16 ) 
									
								end
								
								local KickClose = vgui.Create( "DButton", KickBox )
								KickClose:SetSize( 16, 16 )
								KickClose:SetPos( KickBox:GetWide() - 20, 5 )
								KickClose:SetText( "" )
								KickClose.Paint = function(self)
									draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ) )
								end
								KickClose.DoClick = function()
									KickBox:Remove()
								end
								
								local KickEntry = vgui.Create( "DTextEntry", KickBox )
								KickEntry:SetSize( 200, 20 )
								KickEntry:Center()
								KickEntry:SetDrawBackground( true )
								KickEntry:SetDrawBorder( true )
								KickEntry:SetTextColor( Color( 0, 0, 0) )
								KickEntry:SetText( "Why do you want to kick " .. v:GetName() )
								
								local KickConfirm = vgui.Create( "DButton", KickBox )
								KickConfirm:SetSize( 200, 60 )
								KickConfirm:SetPos( KickBox:GetWide() / 2 - 100, 180 )
								KickConfirm:SetText( "" )
								KickConfirm.Paint = function(self)
									draw.RoundedBox( 5, 0, 0, self:GetWide(), self:GetTall(), Color( 66, 66, 66 ) )
									draw.DrawText( "CONFIRM", "CONFIRM", self:GetWide() / 2, 17, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
								end
								KickConfirm.DoClick = function()
								
								if config.ULX == true then
									RunConsoleCommand( "ulx", "kick", v:GetName(), KickEntry:GetValue() )
								end
								
								if config.FADMIN == true then
									RunConsoleCommand( "_FAdmin", "kick", v:GetName(), KickEntry:GetValue() )
								end
									
									KickBox:Remove()
								end
								
							end )
							AdminRP:AddOption( "Ban", function()
							
								local BanBox = vgui.Create( "DFrame" )
								BanBox:SetSize( 400, 300 )
								BanBox:Center()
								BanBox:MakePopup()
								BanBox:SetTitle( "" )
								BanBox:ShowCloseButton( false )
								BanBox.Paint = function(self)
									draw.RoundedBox( 5, 0, 0, self:GetWide(), self:GetTall(), Color( 33, 33, 33 ) )
									draw.DrawText( "BAN REASON", "RPNAME", self:GetWide() / 2, 45, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
									draw.DrawText( "PRESS ENTER TO MOVE ON", "RPNAME", self:GetWide() / 2, self:GetTall() - 85, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
									
									surface.SetDrawColor( 255, 255, 255, 255 ) 
									surface.SetMaterial( Material( "icon16/cancel.png" ) )
									surface.DrawTexturedRect( BanBox:GetWide() - 20, 5, 16, 16 ) 
									
								end
								
								local BanClose = vgui.Create( "DButton", BanBox )
								BanClose:SetSize( 16, 16 )
								BanClose:SetPos( BanBox:GetWide() - 20, 5 )
								BanClose:SetText( "" )
								BanClose.Paint = function(self)
									draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 0, 0, 0, 0 ) )
								end
								BanClose.DoClick = function()
									BanBox:Remove()
								end
								
								local BanTime = vgui.Create( "DTextEntry", BanBox )
								BanTime:SetSize( 200, 20 )
								BanTime:Center()
								BanTime:SetDrawBackground( true )
								BanTime:SetDrawBorder( true )
								BanTime:SetTextColor( Color( 0, 0, 0) )
								BanTime:SetText( "Enter ban time here." )
								BanTime.OnEnter = function( self )
									BanTime:Remove()
									bantimev = self:GetValue()
									
									local BanReason = vgui.Create( "DTextEntry", BanBox )
									BanReason:SetSize( 200, 20 )
									BanReason:Center()
									BanReason:SetDrawBackground( true )
									BanReason:SetDrawBorder( true )
									BanReason:SetTextColor( Color( 0, 0, 0) )
									BanReason:SetText( "Enter ban reason here." )
									BanReason.OnEnter = function( self, BanTime )
										BanBox:Remove()
										
										if config.ULX == true then
											RunConsoleCommand( "ulx", "ban", v:GetName(), bantimev, self:GetValue() )
										end
										
										if config.FADMIN == true then
											RunConsoleCommand( "_FAdmin", "ban", v:GetName(), bantimev, self:GetValue() )
										end
										
									end
								end
								
							end )
							AdminRP.Paint = function(self)
								draw.RoundedBox( 0, 0, 0, self:GetWide(), self:GetTall(), Color( 97, 97, 97 ) )
							end
						end
					
				end
				
				local SteamAvatar = vgui.Create( "AvatarImage", RPanel )
				SteamAvatar:SetSize( 36, 36 )
				SteamAvatar:SetPos( 10, RPanel:GetTall() / 2 - 18 )
				SteamAvatar:SetPlayer( v, 36 )
				
			end
		
			RScoreboard:Show()
			RScoreboard:MakePopup()
			RScoreboard:SetKeyboardInputEnabled( false )
		end

	end

	function scoreboard:hide()
		RScoreboard:Remove()
	end

	timer.Simple(0.1, function()
		hook.Remove("ScoreboardHide", "FAdmin_scoreboard")
		hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
	end)

	timer.Simple(0.1, function()

	 function GAMEMODE:ScoreboardShow()
		scoreboard:show()
	end

	function GAMEMODE:ScoreboardHide()
		scoreboard:hide()
		end
	end)
end