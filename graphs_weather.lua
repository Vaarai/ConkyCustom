require 'cairo'
require 'settings'
require 'tools'

function conky_WEATHER_forecast (cx_str, cy_str)

	local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str)

	local city = ""
	local country_code = ""

	city = getLocation('city')
	country_code = getLocation('cc')

	if city == "" then if country_code == "" then
		city = default_city
		country_code = default_country_code
	end end

	print("=========" .. city .. " + " .. country_code)

	--Draw today weather icon  
	local image_path = conky_parse("${exec ./openweather_day.py --get_weather_icon --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. "}")
	draw_icon(cr, cx, cy - 16, image_path, transparency_weather_icon)
	--Draw today+1 weather icon
	image_paths = conky_parse("${exec ./openweather_forecast.py --get_weather_icon --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. " --nextday 1}")
	draw_icon(cr, cx - 12, cy + 20, image_paths, transparency_weather_icon)
	--Draw today+2 weather icon
	image_paths = conky_parse("${exec ./openweather_forecast.py --get_weather_icon --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. " --nextday 2}")
	draw_icon(cr, cx + 12, cy + 20, image_paths, transparency_weather_icon)

	--Draw text
	if city ~= nil then if country_code ~= nil then
		----Temperature
		cairo_select_font_face (cr, "Dejavu Sans Book", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
		temperature = conky_parse("${exec ./openweather_day.py --get_temp_c --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. "}")
		if temperature == "" then temperature = "XX°C" else
			temperature = tostring(tonumber(string.format("%.0f", temperature)))
		end
		draw_text(cr, cx, cy, temperature .. "˚C", 16, 0, 37)
		----City
		cairo_select_font_face (cr, "Dejavu Sans Book", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
		draw_text(cr, cx, cy, city, 12, 0, -50)
	end end

	cairo_stroke (cr)

	return ""
end

function conky_WEATHER_wind (cx_str, cy_str)

	local cx = tonumber(cx_str) -- absisce du centre de l'icone
	local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
	
	local arrow_point_len = size_coef*8

	local city = getLocation('city')
	local country_code = getLocation('cc')
 
	local wind_speed = conky_parse("${exec ./openweather_day.py --get_wind_force --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. "}")
	local wind_angle = conky_parse("${exec ./openweather_day.py --get_wind_angle --api_key " .. api_key .. " --city " .. city .. " --ccode " .. country_code .. "}")

	-- Template
	cairo_arc (cr,cx,cy,size_coef*32.0, 0.0, math.pi*2)
	cairo_stroke (cr)

	draw_text(cr, cx, cy, "N", 10, -1, -33)

	cairo_move_to (cr, cx, cy + size_coef*32)
	cairo_line_to (cr, cx, cy + size_coef*36)

	cairo_move_to (cr, cx - size_coef*32, cy)
	cairo_line_to (cr, cx - size_coef*36, cy)

	cairo_move_to (cr, cx + size_coef*32, cy)
	cairo_line_to (cr, cx + size_coef*36, cy)

    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
	cairo_stroke (cr)

	-- Content
	if tonumber(wind_angle) ~= nil then
		local wind_x = tonumber(wind_speed)*math.cos(math.rad(tonumber(wind_angle) + 90))
		local wind_y = tonumber(wind_speed)*math.sin(math.rad(tonumber(wind_angle) + 90))
		local arrow1_x = arrow_point_len*math.cos(math.rad(tonumber(wind_angle) + 90 + 140))
		local arrow1_y = arrow_point_len*math.sin(math.rad(tonumber(wind_angle) + 90 + 140))
		local arrow2_x = arrow_point_len*math.cos(math.rad(tonumber(wind_angle) + 90 - 140))
		local arrow2_y = arrow_point_len*math.sin(math.rad(tonumber(wind_angle) + 90 - 140))

		cairo_move_to (cr, cx - wind_x, cy - wind_y)

		cairo_set_line_width (cr, line_width*1.4)

		cairo_line_to (cr, cx + wind_x, cy + wind_y)
		cairo_move_to (cr, cx + wind_x, cy + wind_y)
		cairo_line_to (cr, cx + wind_x + arrow1_x, cy + wind_y + arrow1_y)
		cairo_move_to (cr, cx + wind_x, cy + wind_y)
		cairo_line_to (cr, cx + wind_x + arrow2_x, cy + wind_y + arrow2_y)

		cairo_set_source_rgba (cr, getColor(rgba_accent_2))
		cairo_stroke (cr)
		cairo_set_line_width (cr, line_width);
	end

	return ""
end
