--This might not be the best way to do this, but still better than before when i overrid it.

Hooks:PostHook(StageEndScreenGui, "init", "missed_shots_tracker_init", function(self, saferect_ws, fullrect_ws, statistics_data)
	local item = self._items[3] -- PERSONAL STATS
	item._stats = {}
	item._main_panel:child(5):clear()

	item:set_stats({
		"total_downed",
		"hit_accuracy",
        "missed_shots",
		"total_kills",
		"total_specials_kills",
		"total_head_shots",
		"favourite_weapon",
		"civilians_killed_penalty"
	})

	if statistics_data then
		self:feed_statistics(statistics_data) --Maybe not important, but just to be sure.
	end
end)

Hooks:PreHook(StageEndScreenGui, "feed_statistics", "MissedShotsTracker", function(self, data)
   data.missed_shots = MissedShotsTracker.values.shots_missed_new
end)