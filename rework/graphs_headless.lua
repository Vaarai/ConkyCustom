require 'cairo'
require 'settings'
require 'tools'

function conky_CPU_square(cx_str, cy_str)
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

function conky_double_RAM_circle(cx_str, cy_str)
    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
    local user_ram = tonumber(conky_parse("${memperc}")) -- Valeur du cercle exterieur
	local swap = tonumber(conky_parse("${swapperc}")) -- Valeur du cercle intérieur

    -----------------------------------------------------
    -- init de la value de la ram
	start_angle=0
    full_circle=2*math.pi
	end_angle=(user_ram/100)*full_circle -- Pour un cercle, il par de 0 à 2*pi radians

	-- premiere partie : Cercle exterieur de RAM
    cairo_move_to (cr, cx, cy)
    cairo_line_to (cr, cx + size_coef*32.0, cy)
	cairo_arc (cr,cx,cy,size_coef*32.0,start_angle,end_angle)
    cairo_close_path(cr)

    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_2))
	cairo_stroke (cr)

    -----------------------------------------------------
    -- Cercle derrière celui de la SWAP
    cairo_arc (cr, cx, cy, size_coef*24.0, 0, math.pi*2.0)

    cairo_set_source_rgba (cr, getColor(rgba_background_a1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
	cairo_stroke (cr)

    -----------------------------------------------------
    -- init de la value de la swap
    alpha=math.acos((100-2*swap)/100)
    start_angle=math.pi*0.5 - alpha
    end_angle=math.pi*0.5 + alpha

    -- deuxieme partie : Cercle interieur de SWAP
    cairo_arc (cr, cx, cy, size_coef*24.0, start_angle, end_angle)
    cairo_close_path(cr)

    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_2))
	cairo_stroke (cr)

    return ""
end

function conky_NET (cx_str, cy_str)

    local sh_output = io.popen("ip -o link show | awk '{print $2,$9}' | grep UP | awk '{gsub(\":\",\"\"); print $1}'")
    local up_interface_name = sh_output:read("*a")
    sh_output:close()

    if (up_interface_name == "") then   conky_NET_disconnected(cx_str, cy_str)
    else conky_NET_arrows(cx_str, cy_str, up_interface_name)
    end

    return ""

end

function conky_NET_disconnected (cx_str, cy_str)
    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone

    cairo_move_to (cr, cx - size_coef*16, cy - size_coef*16)
    cairo_line_to (cr, cx + size_coef*16.0, cy + size_coef*16.0)
    cairo_move_to (cr, cx + size_coef*16, cy - size_coef*16)
    cairo_line_to (cr, cx - size_coef*16.0, cy + size_coef*16.0)

    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    return ""
end

function conky_NET_arrows (cx_str, cy_str, interface_name) 
    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone

    local arrow_color = wifi_ssid_color()

    if arrow_color == 0 then
        conky_NET_disconnected(cx_str, cy_str)
    else
        local downspeed_keyword = "${downspeedf " .. interface_name .. "}"
        local upspeed_keyword = "${upspeedf " .. interface_name .. "}"

        local downspeed = tonumber(conky_parse(downspeed_keyword))
        local upspeed = tonumber(conky_parse(upspeed_keyword))

        local down_value = math.log(downspeed+1)*8
        local up_value = math.log(upspeed+1)*8

        local arrow_spacing = size_coef*18

        ----------------------------------------------
        -- fleche gauche : contenu
        if size_coef*up_value<62.5 then -- Remplir le rectangle
            cairo_move_to (cr, cx - size_coef*6.0 - arrow_spacing, cy + size_coef*32.0)
            cairo_line_to (cr, cx - size_coef*6.0 - arrow_spacing, cy + size_coef*32.0 - size_coef*up_value*0.64)
            cairo_line_to (cr, cx + size_coef*6.0 - arrow_spacing, cy + size_coef*32.0 - size_coef*up_value*0.64)
            cairo_line_to (cr, cx + size_coef*6.0 - arrow_spacing, cy + size_coef*32.0)
            cairo_close_path (cr)
        else -- remplir le triangle
            cairo_move_to (cr, cx - size_coef*8.0 - arrow_spacing, cy + size_coef*32.0)
            cairo_line_to (cr, cx - size_coef*8.0 - arrow_spacing, cy - size_coef*8.0)
            cairo_line_to (cr, cx - size_coef*12.0 - arrow_spacing, cy - size_coef*8.0)
            cairo_line_to (cr, cx - arrow_spacing - 0.5*(100-size_coef*up_value)*0.64, cy + size_coef*32.0 - size_coef*up_value*0.64)
            cairo_line_to (cr, cx - arrow_spacing + 0.5*(100-size_coef*up_value)*0.64, cy + size_coef*32.0 - size_coef*up_value*0.64)
            cairo_line_to (cr, cx + size_coef*12.0 - arrow_spacing, cy - size_coef*8.0)
            cairo_line_to (cr, cx + size_coef*8.0 - arrow_spacing, cy - size_coef*8.0)
            cairo_line_to (cr, cx + size_coef*8.0 - arrow_spacing, cy + size_coef*32.0)
            cairo_close_path (cr)
        end

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)

        -----------------------------------------------
        -- fleche droite : contenu
        if size_coef*down_value<37.5 then -- remplir le triangle
            cairo_move_to (cr, cx + arrow_spacing, cy + size_coef*32.0)
            cairo_line_to (cr, cx + arrow_spacing - 0.5*size_coef*down_value*0.64, cy + size_coef*32.0 - size_coef*down_value*0.64)
            cairo_line_to (cr, cx + arrow_spacing + 0.5*size_coef*down_value*0.64, cy + size_coef*32.0 - size_coef*down_value*0.64)
            cairo_close_path (cr)
        else -- remplir le rectangle
            cairo_move_to (cr, cx + arrow_spacing, cy + size_coef*32.0)
            cairo_line_to (cr, cx - size_coef*12 + arrow_spacing, cy + size_coef*8.0)
            cairo_line_to (cr, cx - size_coef*6.0 + arrow_spacing, cy + size_coef*8.0)
            cairo_line_to (cr, cx - size_coef*6.0 + arrow_spacing, cy + size_coef*32.0 - size_coef*down_value*0.64)
            cairo_line_to (cr, cx + size_coef*6.0 + arrow_spacing, cy + size_coef*32.0 - size_coef*down_value*0.64)
            cairo_line_to (cr, cx + size_coef*6.0 + arrow_spacing, cy + size_coef*8.0)
            cairo_line_to (cr, cx + size_coef*12 + arrow_spacing, cy + size_coef*8.0)
            cairo_close_path (cr)
        end

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)

        ----------------------------------------------
        -- fleche gauche : template
        cairo_move_to (cr, cx - size_coef*6.0 - arrow_spacing, cy + size_coef*32.0)
        cairo_line_to (cr, cx - size_coef*6.0 - arrow_spacing, cy - size_coef*8.0)
        cairo_line_to (cr, cx - size_coef*12.0 - arrow_spacing, cy - size_coef*8.0)
        cairo_line_to (cr, cx - arrow_spacing, cy - size_coef*32.0)
        cairo_line_to (cr, cx + size_coef*12.0 - arrow_spacing, cy - size_coef*8.0)
        cairo_line_to (cr, cx + size_coef*6.0 - arrow_spacing, cy - size_coef*8.0)
        cairo_line_to (cr, cx + size_coef*6.0 - arrow_spacing, cy + size_coef*32.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_background_a0))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_drawing))
        cairo_stroke (cr)

        -----------------------------------------------
        -- fleche droite : template
        cairo_move_to (cr, cx + size_coef*6.0 + arrow_spacing, cy - size_coef*32.0)
        cairo_line_to (cr, cx + size_coef*6.0 + arrow_spacing, cy + size_coef*8.0)
        cairo_line_to (cr, cx + size_coef*12.0 + arrow_spacing, cy + size_coef*8.0)
        cairo_line_to (cr, cx + arrow_spacing, cy + size_coef*32.0)
        cairo_line_to (cr, cx - size_coef*12.0 + arrow_spacing, cy + size_coef*8.0)
        cairo_line_to (cr, cx - size_coef*6.0 + arrow_spacing, cy + size_coef*8.0)
        cairo_line_to (cr, cx - size_coef*6.0 + arrow_spacing, cy - size_coef*32.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_background_a0))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_drawing))
        cairo_stroke (cr)

        -----------------------------------------------
        -- indicateur eth/wifi
        if string.sub(interface_name, 1, 1) == "w" then         -- Wifi dot colored
            cairo_arc (cr, cx, cy, size_coef*4.0, 0, math.pi*2.0)
            cairo_set_source_rgba (cr, arrow_color[1], arrow_color[2], arrow_color[3], 1)
            cairo_fill_preserve (cr)
            cairo_set_source_rgba (cr, arrow_color[1], arrow_color[2], arrow_color[3], 1)
            cairo_stroke (cr)
        elseif string.sub(interface_name, 1, 1) == "e" then     -- Eth rectangle drawing color
            cairo_move_to(cr, cx + size_coef*4.0, cy + size_coef*4.0)
            cairo_line_to(cr, cx + size_coef*4.0, cy - size_coef*4.0)
            cairo_line_to(cr, cx - size_coef*4.0, cy - size_coef*4.0)
            cairo_line_to(cr, cx - size_coef*4.0, cy + size_coef*4.0)
            cairo_line_to(cr, cx + size_coef*4.0, cy + size_coef*4.0)
            cairo_set_source_rgba (cr, getColor(rgba_drawing))
            cairo_fill_preserve (cr)
            cairo_set_source_rgba (cr, getColor(rgba_drawing))
            cairo_stroke (cr)
        end
    end
    return ""
end

function conky_TEMP_meter (cx_str, cy_str)
    local cx = tonumber(cx_str)
    local cy = tonumber(cy_str)

    local cpu_temp = tonumber(conky_parse("${acpitemp}"))
    local sh_output = io.popen("sensors radeon-pci-0100 | grep temp | awk '{ gsub(\"+\",\"\"); split($2,var,\"°\"); print var[1]; }'")
    local sh_temp = sh_output:read("*a")
    local gpu_temp = tonumber(sh_temp)
    sh_output:close()

    local therm_spacing = size_coef*18

    --------------------------------------------------------------------------------------
    -- Thermometre de gauche : valeur
    if cpu_temp<46 then
        cairo_arc (cr, cx - therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx - therm_spacing, cy + size_coef*16.0, size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)
    elseif cpu_temp<90 then
        cairo_arc (cr, cx - therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx - therm_spacing, cy + size_coef*16.0 - (size_coef*cpu_temp - size_coef*46.0), size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)
    else
        cairo_arc (cr, cx - therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx - therm_spacing, cy - size_coef*28.0, size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_warning))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_warning))
        cairo_stroke (cr)
    end

    --------------------------------------------------------------------------------------
    -- Thermometre de droite : GPU
    if gpu_temp<46 then
        cairo_arc (cr, cx + therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx + therm_spacing, cy + size_coef*16.0, size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)
    elseif gpu_temp<90 then
        cairo_arc (cr, cx + therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx + therm_spacing, cy + size_coef*16.0 - (size_coef*gpu_temp - size_coef*46.0), size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_accent_1))
        cairo_stroke (cr)
    else -- Disque > 70 degres
        cairo_arc (cr, cx + therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
        cairo_arc (cr, cx + therm_spacing, cy - size_coef*28.0, size_coef*4.0, math.pi, math.pi*2.0)
        cairo_close_path (cr)

        -- Dessin du disque > 70 degres
        cairo_set_source_rgba (cr, getColor(rgba_warning))
        cairo_fill_preserve (cr)
        cairo_set_source_rgba (cr, getColor(rgba_warning))
        cairo_stroke (cr)
    end

    --------------------------------------------------------------------------------------
    -- Thermometre de gauche : CPU
    cairo_arc (cr, cx - therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
    cairo_line_to (cr, cx - therm_spacing - size_coef*4.0, cy - size_coef*28.0)
    cairo_arc (cr, cx - therm_spacing, cy - size_coef*28.0, size_coef*4.0, math.pi, math.pi*2.0)
    cairo_close_path (cr)

    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    --------------------------------------------------------------------------------------
    -- Thermometre de droite : GPU
    cairo_arc (cr, cx + therm_spacing, cy + size_coef*24.0, size_coef*8.0, (-0.5+(1/6))*math.pi, (-0.5-(1/6))*math.pi)
    cairo_line_to (cr, cx + therm_spacing - size_coef*4.0, cy - size_coef*28.0)
    cairo_arc (cr, cx + therm_spacing, cy - size_coef*28.0, size_coef*4.0, math.pi, math.pi*2.0)
    cairo_close_path (cr)

    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    return ""
end

function conky_DISK_circle (cx_str, cy_str)
    local cx = tonumber(cx_str) -- absisce du centre de l'icone
    local cy = tonumber(cy_str) -- ordonnee du centre de l'icone
    local disk_write = tonumber(conky_parse("${to_bytes ${diskio_write /dev/sda}}"))
    local disk_read = tonumber(conky_parse("${to_bytes ${diskio_read /dev/sda}}"))

    local cyl_spacing = size_coef*6
    local square_size = size_coef*24

    local tilt_coef = 0.5

    local write_value = math.log(disk_write+1)
    local read_value = math.log(disk_read+1)

    -----------------------------------------------------

    half_under_ellipse (cx - square_size - cyl_spacing, cy + square_size, square_size, square_size*tilt_coef)
    cairo_line_to (cr, cx - square_size - cyl_spacing, cy + square_size - size_coef*write_value*0.64)
    half_upper_ellipse (cx - square_size - cyl_spacing, cy + square_size - size_coef*write_value*0.64, square_size, square_size*tilt_coef)
    cairo_close_path (cr)

    cairo_move_to (cr, cx + cyl_spacing, cy - square_size*3/4)

    half_under_ellipse (cx + square_size + cyl_spacing, cy - square_size + size_coef*read_value*0.64, -square_size, square_size*tilt_coef)
    cairo_line_to (cr, cx + square_size + cyl_spacing, cy - square_size*1/2 + size_coef*read_value*0.64)
    half_upper_ellipse (cx + square_size + cyl_spacing, cy - square_size, -square_size, square_size*tilt_coef)
    cairo_close_path (cr)

    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_stroke (cr)

    ellipse (cx - square_size - cyl_spacing, cy + square_size - size_coef*write_value*0.64, square_size, square_size*tilt_coef)
    cairo_set_source_rgba (cr, getColor(rgba_accent_1))
    cairo_stroke (cr)

    -----------------------------------------------------

    half_under_ellipse (cx - square_size - cyl_spacing, cy + square_size, square_size, square_size*tilt_coef)
    cairo_line_to (cr, cx - square_size - cyl_spacing, cy - square_size*3/4)
    half_upper_ellipse (cx - square_size - cyl_spacing, cy - square_size, square_size, square_size*tilt_coef)
    cairo_close_path (cr)

    cairo_move_to (cr, cx + square_size + cyl_spacing, cy - square_size*3/4)

    half_under_ellipse (cx + cyl_spacing, cy + square_size, square_size, square_size*tilt_coef)
    cairo_line_to (cr, cx + cyl_spacing, cy - square_size*3/4)
    half_upper_ellipse (cx + cyl_spacing, cy - square_size, square_size, square_size*tilt_coef)
    cairo_close_path (cr)

    cairo_set_source_rgba (cr, getColor(rgba_background_a0))
    cairo_fill_preserve (cr)
    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    ellipse (cx - square_size - cyl_spacing, cy - square_size, square_size, square_size*tilt_coef)
    cairo_move_to (cr, cx + square_size + cyl_spacing, cy - square_size*3/4)
    ellipse (cx + cyl_spacing, cy - square_size, square_size, square_size*tilt_coef)

    cairo_set_source_rgba (cr, getColor(rgba_drawing))
    cairo_stroke (cr)

    --draw_text(cr, cx - (size_coef*square_size-cyl_spacing)/2 - cyl_spacing, cy, "W", 8, 0, 0)
    --draw_text(cr, cx + (size_coef*square_size-cyl_spacing)/2 + cyl_spacing, cy, "R", 8, 0, 0)

    return ""
end