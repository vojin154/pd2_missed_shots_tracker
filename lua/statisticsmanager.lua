local values = MissedShotsTracker.values
Hooks:PostHook(StatisticsManager, "shot_fired", "shot_fired_missed_shots_tracker", function(self, data)
    local shots_fired = self._global.session.shots_fired
    local total = shots_fired.total
    local hits = shots_fired.hits

    values.shots_missed = total - hits
    MissedShotsTracker:set_shots(values.shots_missed)
end)