require 'cairo'
require 'graphs_weather'

function init_cairo()
    if conky_window == nil then
        return false
    end

    cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height)

    cr = cairo_create(cs)
    return true
end

function conky_start_widgets()
	if (not init_cairo()) then
        return ""
    end

    cairo_set_line_width (cr, line_width);

    
    conky_WEATHER_forecast (gap_x_weather, gap_y_weather)
    conky_WEATHER_wind (gap_x_weather, gap_y_weather - 100)
    
	return ""
end
