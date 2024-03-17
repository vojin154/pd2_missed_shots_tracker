local settings = MissedShotsTracker.settings

Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenusMissedShotsTracker", function(menu_manager, nodes)
    MissedShotsTracker:Load()

    local main_menu_id = "missed_shots_tracker_MAIN"

    MenuHelper:NewMenu(main_menu_id)

    function MenuCallbackHandler:callback_missed_shots_tracker_y(item)
        local text = MissedShotsTracker.text
        settings.y = item:value()
        if alive(text) then
            text:set_y(settings.y * MissedShotsTracker.hud.panel:height())
        end
        MissedShotsTracker:Save()
    end

    function MenuCallbackHandler:callback_missed_shots_tracker_x(item)
        local text = MissedShotsTracker.text
        settings.x = item:value()
        if alive(text) then
            text:set_x(settings.x * MissedShotsTracker.hud.panel:width())
        end
        MissedShotsTracker:Save()
    end

    function MenuCallbackHandler:callback_missed_shots_tracker_font_size(item)
        local text = MissedShotsTracker.text
        settings.font_size = item:value()
        if alive(text) then
            text:set_font_size(settings.font_size)
        end
        MissedShotsTracker:Save()
    end

    function MenuCallbackHandler:callback_missed_shots_tracker_fonts(item)
        local text = MissedShotsTracker.text
        settings.font = MissedShotsTracker.fonts[item:value()]
        settings.saved_font = item:value()
        if alive(text) then
            text:set_font(Idstring(settings.font))
        end
        MissedShotsTracker:Save()
    end

    function MenuCallbackHandler:callback_missed_shots_tracker_reset(item)
        settings = deep_clone(MissedShotsTracker.default)
        local items_table = {
            ["missed_shots_tracker_fonts"] = settings.saved_font,
            ["missed_shots_tracker_font_size"] = settings.font_size,
            ["missed_shots_tracker_x"] = settings.x,
            ["missed_shots_tracker_y"] = settings.y
        }
    
        local function reset_item(_item)
            local value = items_table[_item._parameters.name]
            if value and _item.set_value then
                _item:set_value(value)
            end
        end
    
        local node_items = item._parameters.gui_node.row_items
        for _, v in pairs(node_items) do
            reset_item(v.item)
        end
    
        local text = MissedShotsTracker.text
        if alive(text) then
            for i, v in pairs(settings) do
                if i == "font" then
                    v = Idstring(v)
                end
    
                local func = text["set_" .. i]
                if func then
                    func(text, v)
                end
            end
        end
        MissedShotsTracker:Save()
    end

    MenuHelper:AddMultipleChoice({
        id = "missed_shots_tracker_fonts",
        title = "missed_shots_tracker_fonts_title",
        desc = "missed_shots_tracker_fonts_desc",
        callback = "callback_missed_shots_tracker_fonts",
        items = MissedShotsTracker.fonts,
        value = settings.saved_font,
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
        value = settings.font_size,
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
        value = settings.x,
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
        value = settings.y,
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
