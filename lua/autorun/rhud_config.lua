RHud = {}
local config = RHud

// HUD Enabled.

RHud.HUDEnabled = true

// Main HUD Colors

RHud.JobColor = false -- True if you want the job text to be the color of the persons job.

RHud.MainColor = Color( 24, 24, 24 ) -- The main color of the HUD, default is the dark black color.
RHud.SecondaryColor = Color( 38, 38, 38 ) -- Secondary color is the grey HUD color.
RHud.OutlineColor = Color( 0, 0, 0 ) -- The outline of the HUD blocks.

RHud.MainTextColor = Color( 255, 255, 255 ) -- The color of the text saying Health, Hunger, Armor, Job, Name, Money, Lockdown, and Ammo.
RHud.SalaryColor = Color( 142, 142, 142 ) -- Color of the salary text.

// Agenda Colors

RHud.AgendaMain = Color( 24, 24, 24 ) -- Color of the dark black area.
RHud.AgendaSecond = Color( 38, 38, 38 ) -- Color of the top bar.
RHud.AgendaOutline = Color( 0, 0, 0 ) -- Color of the agenda outline.

RHud.AgendaJobTitle = Color( 255, 255, 255 ) -- Agenda of the job at the top of agenda, e.g. "Police agenda"
RHud.AgendaText = Color( 255, 255, 255 ) -- The color of the agenda text.

// Health Color

RHud.HealthBackground = Color( 38, 38, 38 ) -- Background of box behind health.
RHud.HealthColor = Color( 201, 0, 0 ) -- Color of the health bar.

// Armor Color

RHud.ArmorBackground = Color( 38, 38, 38 ) -- Background of box behind armor.
RHud.ArmorColor = Color( 0, 144, 201 ) -- Color of the armor bar.

// Hunger Color

RHud.HungerBackground = Color( 38, 38, 38 ) -- Background of box behind hunger.
RHud.HungerColor = Color( 255, 157, 0 ) -- Color of the hunger bar.

// Hunger Mod

RHud.HungerMod = false -- Set to true if you have hunger mod on your server, false if not.