require 'cairo'
require 'graphs_headless'


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

function conky_main()
    if (not init_cairo()) then
        return ""
    end

    cairo_set_line_width (cr, line_width);

    conky_CPU_square (gap_x_headless, gap_y_headless)
    conky_double_RAM_circle (gap_x_headless, gap_y_headless + spacing*1)
    conky_NET (gap_x_headless, gap_y_headless + spacing*2)
    conky_TEMP_meter (gap_x_headless, gap_y_headless + spacing*3)
    conky_DISK_circle (gap_x_headless, gap_y_headless + spacing*4)

return ""
end