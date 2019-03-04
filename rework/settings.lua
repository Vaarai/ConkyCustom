-- ###Openweather settings###
    api_key = "81baa8fffa0ec25a9a2d825c57d4adfe"

-- ###Colors settings###
    rgba_drawing        = {243/255, 243/255, 243/255, 1} 
    rgba_warning        = {1, 0, 0, 1/2}
    rgba_accent_1       = {22/255, 122/255, 191/255, 1/2}
    rgba_accent_2       = {22/255, 122/255, 191/255, 4/5}
    rgba_background_a1  = {0, 0, 0, 1}
    rgba_background_a0  = {rgba_background_a1[1], rgba_background_a1[2], rgba_background_a1[3], 0}
    transparency_weather_icon = 1.0
    -- See also tools.lua to set wifi detection color

-- ###Geometry settings###
    line_width = 1.5
    size_coef = 4/5     -- Headless
    spacing = size_coef*80

    gap_x_headless = 48
    gap_y_headless = 48

    gap_x_weather = 358
    gap_y_weather = 340