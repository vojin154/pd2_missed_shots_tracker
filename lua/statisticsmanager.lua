
Hooks:PostHook(StatisticsManager, "shot_fired", "ShotsMissedTracker", function(self, data)
    MissedShotsTracker.values.shots_missed_new = self._global.session.shots_fired.total - self._global.session.shots_fired.hits
end)