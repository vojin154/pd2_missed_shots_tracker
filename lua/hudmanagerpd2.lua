
function MissedShotsTracker:init()

	if managers.hud ~= nil then 
		self.hud = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_FULLSCREEN_PD2)
		self.text = self.hud.panel:text({
			vertical = "top",
			align = "left",
			blend_mode = "normal",
			y = self.settings.y * self.hud.panel:height(),
			layer = 0,
			text = "Shots missed: " .. tostring(self.values.shots_missed),
			font = self.settings.chosen_font,
			font_size = self.settings.font_size,
			x = self.settings.x * self.hud.panel:width(),
			color = Color.white
		})
	end

end

function MissedShotsTracker:update()

	if self.values.shots_missed_new >= self.values.shots_missed then
		self.text:set_text("Shots missed: " .. tostring(self.values.shots_missed))
		self.values.shots_missed = self.values.shots_missed_new
	end

end

Hooks:PostHook(HUDManager, "_player_hud_layout", "MissedShotsTracker", function(self)
	MissedShotsTracker:init()
end)

Hooks:PostHook(HUDManager, "update", "MissedShotsTrackerUpdater", function(self)
	MissedShotsTracker:update()
end)