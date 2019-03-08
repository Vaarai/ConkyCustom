-- ################################################################# 4 Threads
function conky_CPU4 (cx_str, cy_str)
    --cairo_set_source_rgba (cr, getColor(rgba_warning))

    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
    local cpu1 = tonumber(conky_parse("${cpu cpu1}"))
    local cpu2 = tonumber(conky_parse("${cpu cpu2}"))
    local cpu3 = tonumber(conky_parse("${cpu cpu3}"))
    local cpu4 = tonumber(conky_parse("${cpu cpu4}"))

    -----------------------------------------------------
    -- Octogone de 100%
    cairo_move_to (cr, cx + size_coef*32.0, cy)
    cairo_line_to (cr, cx + size_coef*32.0, cy)
    cairo_line_to (cr, cx, cy + size_coef*32.0)
    cairo_line_to (cr, cx - size_coef*32.0, cy)
    cairo_line_to (cr, cx, cy - size_coef*32.0)
    cairo_line_to (cr, cx + size_coef*32.0, cy)

    -- Dessin des 100%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))  -- Inside color
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing)) -- Line color
	cairo_stroke (cr)

    -- Octogone de 50%
    cairo_move_to (cr, cx + size_coef*16.0, cy)
    cairo_line_to (cr, cx + size_coef*16.0, cy)
    cairo_line_to (cr, cx, cy + size_coef*16.0)
    cairo_line_to (cr, cx - size_coef*16.0, cy)
    cairo_line_to (cr, cx, cy - size_coef*16.0)
    cairo_line_to (cr, cx + size_coef*16.0, cy)

    -- Dessin des 50%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    -- Octogone des CPU
    cairo_line_to (cr, cx + size_coef*32.0*(cpu1/100), cy)
    cairo_line_to (cr, cx, cy + size_coef*32.0*(cpu2/100))
    cairo_line_to (cr, cx - size_coef*32.0*(cpu3/100), cy)
    cairo_line_to (cr, cx, cy - size_coef*32.0*(cpu4/100))
    cairo_line_to (cr, cx + size_coef*32.0*(cpu1/100), cy)

    -- Dessin du graph
    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_2))
    cairo_stroke (cr)

    return ""
end


-- ################################################################# 8 Threads
function conky_CPU8 (cx_str, cy_str)

    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
    local cpu1 = tonumber(conky_parse("${cpu cpu1}"))
    local cpu2 = tonumber(conky_parse("${cpu cpu2}"))
    local cpu3 = tonumber(conky_parse("${cpu cpu3}"))
    local cpu4 = tonumber(conky_parse("${cpu cpu4}"))
    local cpu5 = tonumber(conky_parse("${cpu cpu5}"))
    local cpu6 = tonumber(conky_parse("${cpu cpu6}"))
    local cpu7 = tonumber(conky_parse("${cpu cpu7}"))
    local cpu8 = tonumber(conky_parse("${cpu cpu8}"))

    -----------------------------------------------------
    -- Octogone de 100%
    cairo_move_to (cr, cx + size_coef*32.0, cy)
    cairo_line_to (cr, cx + size_coef*32.0, cy)
    cairo_line_to (cr, cx + size_coef*24.0, cy + size_coef*24.0)
    cairo_line_to (cr, cx, cy + size_coef*32.0)
    cairo_line_to (cr, cx - size_coef*24.0, cy + size_coef*24.0)
    cairo_line_to (cr, cx - size_coef*32.0, cy)
    cairo_line_to (cr, cx - size_coef*24.0, cy - size_coef*24.0)
    cairo_line_to (cr, cx, cy - size_coef*32.0)
    cairo_line_to (cr, cx + size_coef*24.0, cy - size_coef*24.0)
    cairo_line_to (cr, cx + size_coef*32.0, cy)

    -- Dessin des 100%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))  -- Inside color
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing)) -- Line color
	cairo_stroke (cr)

    -- Octogone de 50%
    cairo_move_to (cr, cx + size_coef*16.0, cy)
    cairo_line_to (cr, cx + size_coef*16.0, cy)
    cairo_line_to (cr, cx + size_coef*12.0, cy + size_coef*12.0)
    cairo_line_to (cr, cx, cy + size_coef*16.0)
    cairo_line_to (cr, cx - size_coef*12.0, cy + size_coef*12.0)
    cairo_line_to (cr, cx - size_coef*16.0, cy)
    cairo_line_to (cr, cx - size_coef*12.0, cy - size_coef*12.0)
    cairo_line_to (cr, cx, cy - size_coef*16.0)
    cairo_line_to (cr, cx + size_coef*12.0, cy - size_coef*12.0)
    cairo_line_to (cr, cx + size_coef*16.0, cy)

    -- Dessin des 50%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    -- Octogone des CPU
    cairo_line_to (cr, cx + size_coef*32.0*(cpu8/100), cy)
    cairo_line_to (cr, cx + size_coef*24.0*(cpu1/100), cy + size_coef*24.0*(cpu1/100))
    cairo_line_to (cr, cx, cy + size_coef*32.0*(cpu2/100))
    cairo_line_to (cr, cx - size_coef*24.0*(cpu3/100), cy + size_coef*24.0*(cpu3/100))
    cairo_line_to (cr, cx - size_coef*32.0*(cpu4/100), cy)
    cairo_line_to (cr, cx - size_coef*24.0*(cpu5/100), cy - size_coef*24.0*(cpu5/100))
    cairo_line_to (cr, cx, cy - size_coef*32.0*(cpu6/100))
    cairo_line_to (cr, cx + size_coef*24.0*(cpu7/100), cy - size_coef*24.0*(cpu7/100))
    cairo_line_to (cr, cx + size_coef*32.0*(cpu8/100), cy)

    -- Dessin du graph
    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_2))
    cairo_stroke (cr)

    return ""
end

-- ################################################################# 12 Threads
function conky_CPU12 (cx_str, cy_str)

    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
    local cpu1 = tonumber(conky_parse("${cpu cpu1}"))
    local cpu2 = tonumber(conky_parse("${cpu cpu2}"))
    local cpu3 = tonumber(conky_parse("${cpu cpu3}"))
    local cpu4 = tonumber(conky_parse("${cpu cpu4}"))
    local cpu5 = tonumber(conky_parse("${cpu cpu5}"))
    local cpu6 = tonumber(conky_parse("${cpu cpu6}"))
    local cpu7 = tonumber(conky_parse("${cpu cpu7}"))
    local cpu8 = tonumber(conky_parse("${cpu cpu8}"))
    local cpu9 = tonumber(conky_parse("${cpu cpu9}"))
    local cpu10 = tonumber(conky_parse("${cpu cpu10}"))
    local cpu11 = tonumber(conky_parse("${cpu cpu11}"))
    local cpu12 = tonumber(conky_parse("${cpu cpu12}"))

    -----------------------------------------------------
    -- Octogone de 100%
    cairo_move_to (cr, cx + size_coef*32.0, cy)
    cairo_line_to (cr, cx + size_coef*28.0, cy + size_coef*16.0)
    cairo_line_to (cr, cx + size_coef*16.0, cy + size_coef*28.0)
    cairo_line_to (cr, cx, cy + size_coef*32.0)
    cairo_line_to (cr, cx - size_coef*16.0, cy + size_coef*28.0)
    cairo_line_to (cr, cx - size_coef*28.0, cy + size_coef*16.0)
    cairo_line_to (cr, cx - size_coef*32.0, cy)
    cairo_line_to (cr, cx - size_coef*28.0, cy - size_coef*16.0)
    cairo_line_to (cr, cx - size_coef*16.0, cy - size_coef*28.0)
    cairo_line_to (cr, cx, cy - size_coef*32.0)
    cairo_line_to (cr, cx + size_coef*16.0, cy - size_coef*28.0)
    cairo_line_to (cr, cx + size_coef*28.0, cy - size_coef*16.0)
    cairo_line_to (cr, cx + size_coef*32.0, cy)

    -- Dessin des 100%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))  -- Inside color
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing)) -- Line color
	cairo_stroke (cr)

    -- Octogone de 50%
    cairo_move_to (cr, cx + size_coef*16.0, cy)
    cairo_line_to (cr, cx + size_coef*14.0, cy + size_coef*8.0)
    cairo_line_to (cr, cx + size_coef*8.0, cy + size_coef*14.0)
    cairo_line_to (cr, cx, cy + size_coef*16.0)
    cairo_line_to (cr, cx - size_coef*8.0, cy + size_coef*14.0)
    cairo_line_to (cr, cx - size_coef*14.0, cy + size_coef*8.0)
    cairo_line_to (cr, cx - size_coef*16.0, cy)
    cairo_line_to (cr, cx - size_coef*14.0, cy - size_coef*8.0)
    cairo_line_to (cr, cx - size_coef*8.0, cy - size_coef*14.0)
    cairo_line_to (cr, cx, cy - size_coef*16.0)
    cairo_line_to (cr, cx + size_coef*8.0, cy - size_coef*14.0)
    cairo_line_to (cr, cx + size_coef*14.0, cy - size_coef*8.0)
    cairo_line_to (cr, cx + size_coef*16.0, cy)

    -- Dessin des 50%
    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    -- Octogone des CPU
    cairo_move_to (cr, cx + (cpu1/100)*size_coef*32.0, cy)
    cairo_line_to (cr, cx + (cpu2/100)*size_coef*28.0, cy + (cpu2/100)*size_coef*16.0)
    cairo_line_to (cr, cx + (cpu3/100)*size_coef*16.0, cy + (cpu3/100)*size_coef*28.0)
    cairo_line_to (cr, cx, cy + (cpu4/100)*size_coef*32.0)
    cairo_line_to (cr, cx - (cpu5/100)*size_coef*16.0, cy + (cpu5/100)*size_coef*28.0)
    cairo_line_to (cr, cx - (cpu6/100)*size_coef*28.0, cy + (cpu6/100)*size_coef*16.0)
    cairo_line_to (cr, cx - (cpu7/100)*size_coef*32.0, cy)
    cairo_line_to (cr, cx - (cpu8/100)*size_coef*28.0, cy - (cpu8/100)*size_coef*16.0)
    cairo_line_to (cr, cx - (cpu9/100)*size_coef*16.0, cy - (cpu9/100)*size_coef*28.0)
    cairo_line_to (cr, cx, cy - (cpu10/100)*size_coef*32.0)
    cairo_line_to (cr, cx + (cpu11/100)*size_coef*16.0, cy - (cpu11/100)*size_coef*28.0)
    cairo_line_to (cr, cx + (cpu12/100)*size_coef*28.0, cy - (cpu12/100)*size_coef*16.0)
    cairo_line_to (cr, cx + (cpu1/100)*size_coef*32.0, cy)

    -- Dessin du graph
    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_2))
    cairo_stroke (cr)

    return ""
end