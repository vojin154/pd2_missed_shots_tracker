function MissedShotsTracker:init()
	local settings = self.settings
	if managers.hud ~= nil then 
		self.hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
		self.text = self.hud.panel:text({
			vertical = "top",
			align = "left",
			blend_mode = "normal",
			y = settings.y * self.hud.panel:height(),
			layer = 0,
			text = "Shots missed: 0",
			font = settings.font,
			font_size = settings.font_size,
			x = settings.x * self.hud.panel:width(),
			color = Color.white
		})
	end
end

function MissedShotsTracker:set_shots(amount)
	local text = string.format("Shots missed: %s", amount)
	self.text:set_text(text)
end

Hooks:PostHook(HUDManager, "_player_hud_layout", "MissedShotsTracker", function(self)
	MissedShotsTracker:init()
end)