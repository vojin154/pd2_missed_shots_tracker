Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusMissedShotsTracker", function(menu_manager, nodes)
    MissedShotsTracker:Load()

    local main_menu_id = "missed_shots_tracker_MAIN"

    MenuHelper:NewMenu(main_menu_id)

    MenuCallbackHandler.callback_missed_shots_tracker_y = function(self, item)
        MissedShotsTracker.settings.y = item:value()
        if alive(MissedShotsTracker.text) then
            MissedShotsTracker.text:set_y(MissedShotsTracker.settings.y * MissedShotsTracker.hud.panel:height())
        end
        MissedShotsTracker:Save()
    end

    MenuCallbackHandler.callback_missed_shots_tracker_x = function(self, item)
        MissedShotsTracker.settings.x = item:value()
        if alive(MissedShotsTracker.text) then
            MissedShotsTracker.text:set_x(MissedShotsTracker.settings.x * MissedShotsTracker.hud.panel:width())
        end
        MissedShotsTracker:Save()
    end

    MenuCallbackHandler.callback_missed_shots_tracker_font_size = function(self, item)
        MissedShotsTracker.settings.font_size = item:value()
        if alive(MissedShotsTracker.text) then
            MissedShotsTracker.text:set_font_size(MissedShotsTracker.settings.font_size)
        end
        MissedShotsTracker:Save()
    end

    MenuCallbackHandler.callback_missed_shots_tracker_fonts = function(self, item)
        MissedShotsTracker.settings.chosen_font = MissedShotsTracker.fonts[item:value()]
        MissedShotsTracker.settings.saved_font = item:value()
        if alive(MissedShotsTracker.text) then
            MissedShotsTracker.text:set_font(Idstring(MissedShotsTracker.settings.chosen_font))
        end
        MissedShotsTracker:Save()
    end

    MenuCallbackHandler.callback_missed_shots_tracker_reset = function(self, item)
        
        MenuHelper:ResetItemsToDefaultValue(item, {["MissedShotsTracker.settings.chosen_font"] = true}, "fonts/font_small_mf")
        MenuHelper:ResetItemsToDefaultValue(item, {["missed_shots_tracker_font_size"] = true}, 20)
        MenuHelper:ResetItemsToDefaultValue(item, {["missed_shots_tracker_x"] = true}, 0)
        MenuHelper:ResetItemsToDefaultValue(item, {["missed_shots_tracker_y"] = true}, 0)
    
        MissedShotsTracker:Save()
    
    end

    MenuHelper:AddMultipleChoice({
        id = "missed_shots_tracker_fonts",
        title = "missed_shots_tracker_fonts_title",
        desc = "missed_shots_tracker_fonts_desc",
        callback = "callback_missed_shots_tracker_fonts",
        items = MissedShotsTracker.fonts,
        value = MissedShotsTracker.settings.saved_font,
        menu_id = main_menu_id,
        priority = 8
    })

    MenuHelper:AddDivider({
        id = "missed_shots_tracker_fonts_divider",
        size = 16,
        menu_id = main_menu_id,
        priority = 7
    })
    
    MenuHelper:AddSlider({
        id = "missed_shots_tracker_font_size",
        title = "missed_shots_tracker_size_title",
        description = "missed_shots_tracker_size_desc",
        callback = "callback_missed_shots_tracker_font_size",
        value = MissedShotsTracker.settings.font_size,
        min = 0,
        max = 100,
        step = 0.1,
        show_value = true,
        menu_id = main_menu_id,
        priority = 6
    })

    MenuHelper:AddDivider({
        id = "missed_shots_tracker_fonts_size_divider",
        size = 16,
        menu_id = main_menu_id,
        priority = 5
    })

    MenuHelper:AddSlider({
        id = "missed_shots_tracker_x",
        title = "X",
        callback = "callback_missed_shots_tracker_x",
        value = MissedShotsTracker.settings.x,
        min = 0,
        max = 0.91,
        step = 0.01,
        show_value = true,
        menu_id = main_menu_id,
        priority = 4,
        localized = false
    })

    MenuHelper:AddDivider({
        id = "missed_shots_tracker_axis_divider",
        size = 0.5,
        menu_id = main_menu_id,
        priority = 3
    })

    MenuHelper:AddSlider({
        id = "missed_shots_tracker_y",
        title = "Y",
        callback = "callback_missed_shots_tracker_y",
        value = MissedShotsTracker.settings.y,
        min = 0,
        max = 0.97,
        step = 0.01,
        show_value = true,
        menu_id = main_menu_id,
        priority = 2,
        localized = false
    })

    MenuHelper:AddDivider({
        id = "missed_shots_tracker_reset_divider",
        size = 16,
        menu_id = main_menu_id,
        priority = 1
    })

    MenuHelper:AddButton({
        id = "missed_shots_tracker_reset",
        title = "RESET",
        callback = "callback_missed_shots_tracker_reset",
        menu_id = main_menu_id,
        priority = 0,
        localized = false
    })

    nodes[main_menu_id] = MenuHelper:BuildMenu(main_menu_id, { area_bg = "none" })
    MenuHelper:AddMenuItem(nodes["blt_options"], main_menu_id, "missed_shots_tracker_menu", "missed_shots_tracker_menu_desc")

end)
