include("autorun/rhud_config.lua")
local config = RHud

if RHud.HUDEnabled == true then
	local smoothHealth = 100
	local smoothArmor = 100

	function MainHUD()

		draw.RoundedBox( 0, 5, ScrH() - 135, 390, 130, RHud.MainColor )
		surface.SetDrawColor( RHud.OutlineColor )
		surface.DrawOutlinedRect( 5, ScrH() - 135, 390, 130 )
		
		draw.RoundedBox( 0, 245, ScrH() - 135, 150, 80, RHud.SecondaryColor )
		surface.SetDrawColor( RHud.OutlineColor )
		surface.DrawOutlinedRect( 245, ScrH() - 135, 150, 80 )
		
		draw.RoundedBox( 0, 5, ScrH() - 55, 390, 50, RHud.MainColor )
		surface.SetDrawColor( RHud.OutlineColor )
		surface.DrawOutlinedRect( 5, ScrH() - 55, 390, 50 )
		
		draw.RoundedBox( 0, 5, ScrH() - 135, 50, 80, RHud.SecondaryColor )
		surface.SetDrawColor( RHud.OutlineColor )
		surface.DrawOutlinedRect( 5, ScrH() - 135, 50, 80 )
		
		surface.SetDrawColor( RHud.OutlineColor )
		surface.DrawOutlinedRect( 5, ScrH() - 135, 50, 43 )
		
		local Money = LocalPlayer():getDarkRPVar("money")
		if string.len(Money) > 7 then
			Money = string.sub(Money, 1, 7) .. ".."
		end 
		
		draw.SimpleText( "$ " .. Money, "Money", 319, ScrH() - 120, RHud.MainTextColor, TEXT_ALIGN_CENTER )
		draw.SimpleText( "SALARY: $ " .. LocalPlayer():getDarkRPVar("salary"), "Salary", 319, ScrH() - 90, RHud.SalaryColor, TEXT_ALIGN_CENTER )
		
		local Name = LocalPlayer():Nick()
		if string.len(Name) > 13 then
			Name = string.sub(Name, 1, 13) .. ".."
		end 
		
		local Job = LocalPlayer():getDarkRPVar("job")
		if string.len(Job) > 8 then
			Job = string.sub(Job, 1, 8) .. ".."
		end 
		
		draw.SimpleText( Name, "Nick", 130, ScrH() - 120, RHud.MainTextColor, TEXT_ALIGN_LEFT )
		if RHud.JobColor == true then
			draw.SimpleText( Job, "Job", 180, ScrH() - 95, team.GetColor(LocalPlayer():Team()), TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( Job, "Job", 180, ScrH() - 95, RHud.MainTextColor, TEXT_ALIGN_CENTER )
		end
		
		//local health = LocalPlayer():Health()
		smoothHealth = Lerp(0.03, smoothHealth, LocalPlayer():Health())
		smoothArmor = Lerp(0.03, smoothArmor, LocalPlayer():Armor())
		
		draw.RoundedBox( 0, 75, ScrH() - 45, 300, 10, RHud.HealthBackground )
		draw.RoundedBox( 0, 75, ScrH() - 45, math.Clamp(smoothHealth, 0, 100) * 3, 10, RHud.HealthColor )
		
		draw.RoundedBox( 0, 75, ScrH() - 25, 300, 10, RHud.ArmorBackground )
		draw.RoundedBox( 0, 75, ScrH() - 26, math.Clamp(smoothArmor, 0, 100) * 3, 10, RHud.ArmorColor )
		
		draw.SimpleText( "HEALTH:", "Health", 15, ScrH() - 48, RHud.MainTextColor, TEXT_ALIGN_LEFT )
		draw.SimpleText( "ARMOR:", "Health", 15, ScrH() - 28, RHud.MainTextColor, TEXT_ALIGN_LEFT )
		
		if LocalPlayer():getDarkRPVar("wanted") then
			draw.SimpleText("!", "Wanted", 25, ScrH() - 132.5, Color( 255, 255, 255 ) )
		else
			draw.SimpleText("!", "Wanted", 25, ScrH() - 132.5, Color( 0, 0, 0 ) )
		end
		
		if LocalPlayer():getDarkRPVar("HasGunlicense") then
			surface.SetDrawColor( 255, 255, 255, 255 ) 
			surface.SetMaterial( Material( "materials/rhud/gunlicensehave.png" ) )
			surface.DrawTexturedRect( 15, ScrH() - 89, 30, 30 )
		else
			surface.SetDrawColor( 255, 255, 255, 255 ) 
			surface.SetMaterial( Material( "materials/rhud/gunlicense.png" ) )
			surface.DrawTexturedRect( 15, ScrH() - 89, 30, 30 ) 
		end
		
	end
	hook.Add("HUDPaint", "MainHUD", MainHUD)

	function AmmoHUD()

		if LocalPlayer():Alive()  == false then return end

			local weapon = LocalPlayer():GetActiveWeapon()
			if weapon and IsValid( weapon ) then
					
			local clip = weapon:Clip1()
			local ammo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) 
			if clip == -1 or clip <= 0 and ammo <= 0 then return end
						
			if ammo and clip >= 0 then
				draw.RoundedBox( 0, ScrW() - 205, ScrH() - 85, 200, 80, RHud.MainColor )
				surface.SetDrawColor( RHud.OutlineColor )
				surface.DrawOutlinedRect( ScrW() - 205, ScrH() - 85, 200, 80 )

				draw.SimpleText( clip .. " / " .. ammo, "Ammo", ScrW() - 105, ScrH() - 65, RHud.MainTextColor, TEXT_ALIGN_CENTER )			
			end
		end

	end
	hook.Add("HUDPaint", "MainHud", AmmoHUD)

	function AgendaHUD()

		local agenda = LocalPlayer():getAgendaTable()
		if not agenda then return end
				
		draw.RoundedBox( 0, 5, 5, 350, 150, RHud.AgendaMain )
		surface.SetDrawColor( RHud.AgendaOutline )
		surface.DrawOutlinedRect( 5, 5, 350, 150 )
		
		draw.RoundedBox( 0, 5, 5, 350, 40, RHud.AgendaSecond )
		surface.SetDrawColor( RHud.AgendaOutline )
		surface.DrawOutlinedRect( 5, 5, 350, 40 )
		
		draw.DrawText( agenda.Title, "Job", 175, 10, RHud.AgendaJobTitle, TEXT_ALIGN_CENTER )
				
		local text = LocalPlayer():getDarkRPVar("agenda") or ""
		text = text:gsub("//", "\n"):gsub("\\n", "\n")
		text = DarkRP.textWrap(text, "DarkRPHUD1", 300)
				
		draw.DrawText(text, "Salary", 10, 50, RHud.AgendaText )
				
	end
	hook.Add("HUDPaint", "Agenda", AgendaHUD)

	if RHud.HungerMod == true then
		local smoothHunger = 300

		function FoodHUD()

			draw.RoundedBox( 0, 390, ScrH() - 55, 250, 50, RHud.MainColor )
			surface.SetDrawColor( RHud.OutlineColor )
			surface.DrawOutlinedRect( 390, ScrH() - 55, 250, 50 )
			
			smoothHunger = Lerp( 0.03, smoothHunger, LocalPlayer():getDarkRPVar( "Energy" ) )
			
			draw.RoundedBox( 0, 460, ScrH() - 35, 160, 10, RHud.HungerBackground )
			draw.RoundedBox( 0, 460, ScrH() - 35, math.Clamp(smoothHunger, 0, 100) * 1.6, 10, RHud.HungerColor )
			
			draw.SimpleText( "HUNGER:", "Health", 400, ScrH() - 38, RHud.MainTextColor, TEXT_ALIGN_LEFT )

		end
		hook.Add("HUDPaint", "Hunger", FoodHUD)
	end

	function LockdownHUD()

		if GetGlobalBool("DarkRP_LockDown") then
			draw.RoundedBox( 0, 5, ScrH() - 170, 300, 30, RHud.MainColor )
			draw.SimpleText( "Lockdown is in progress, please go home!", "Lockdown", 152, ScrH() - 163, RHud.MainTextColor, TEXT_ALIGN_CENTER )
		end

	end
	hook.Add("HUDPaint", "Lockdown", LockdownHUD)

	local avatar
	function HUDValidCheck()
		if IsValid( LocalPlayer() ) && !IsValid( avatar ) then
			avatar = vgui.Create( "AvatarImage" )
			avatar:SetSize( 60, 60 )
			avatar:SetPos( 65, ScrH() - 125 )
			avatar:SetPlayer( LocalPlayer(), 60 )
		end
	end
	hook.Add( "HUDPaint", "AvatarCheck", HUDValidCheck )

	function hidehud(name)
		for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "DarkRP_HUD", "DarkRP_Hungermod", "CHudSecondaryAmmo", "DarkRP_LocalPlayerHUD", "DarkRP_EntityDisplay"})do
			if name == v then return false end
		end
	end
	hook.Add("HUDShouldDraw", "hide", hidehud)
end