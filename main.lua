if not MissedShotsTracker then
	_G.MissedShotsTracker = _G.MissedShotsTracker or {}
	MissedShotsTracker._path = ModPath
	MissedShotsTracker._data_path = SavePath .. "MissedShotsTracker.txt"
	MissedShotsTracker.default = {
		saved_font = 1,
		x = 0,
		y = 0,
		font = "fonts/font_small_mf",
		font_size = 20
	}
	MissedShotsTracker.settings = deep_clone(MissedShotsTracker.default)
	MissedShotsTracker.fonts = {
		"fonts/font_small_mf",
		"fonts/font_eurostile_ext",
		"fonts/font_large",
		"fonts/font_medium",
		"fonts/font_medium_noshadow",
		"fonts/font_medium_shadow",
		"fonts/font_small",
		"fonts/font_small_noshadow",
		"fonts/font_small_shadow",
	}

	MissedShotsTracker.values = {
		shots_missed = 0
	}

    function MissedShotsTracker:Load()
		local save_data
		if io.file_is_readable(self._data_path) then
			save_data = io.load_as_json(self._data_path)
		end
		if save_data then
			for k, v in pairs(save_data) do
				self.settings[k] = v
			end
		end
    end
    
    function MissedShotsTracker:Save()
        local file = io.open(self._data_path, "w+")
        if file then
			file:write(json.encode(self.settings))
            file:close()
        end
    end

    Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_missed_shots_tracker", function(loc)
		loc:load_localization_file(MissedShotsTracker._path .. "loc/english.json")
	end)
    
end

MissedShotsTracker:Load()

local required = {}
if RequiredScript and not required[RequiredScript] then
	local fname = MissedShotsTracker._path .. RequiredScript:gsub(".+/(.+)", "lua/%1.lua")
	if io.file_is_readable(fname) then
		dofile(fname)
	end

	required[RequiredScript] = true
end