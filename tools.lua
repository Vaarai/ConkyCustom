function getColor(rgba)
    return rgba[1], rgba[2], rgba[3], rgba[4]
end

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return (tonumber("0x"..hex:sub(1,2))/255), (tonumber("0x"..hex:sub(3,4))/255), tonumber(("0x"..hex:sub(5,6))/255)
end

-- Return a color for know ssid, black for unknow ssid and 0 if not connected
function wifi_ssid_color ()
    local sh_output = io.popen("iwgetid -r")
    local ssid = sh_output:read("*a")
    sh_output:close()
    local color = {}

    if      ssid == "" then             color = 0
    elseif  ssid == "EMA\n" then        color = {0/255, 103/255, 154/255}
    elseif  ssid == "JW-AP\n" then      color = {236/255, 74/255, 148/255}
    elseif  ssid == "Lepengouin\n" then color = {161/255, 236/255, 148/255}
    else                                color = {0, 0, 0}
    end

    return color
end

function getLocation (t)
	if t == 'city' then
		return conky_parse("${exec ./whereami_city.sh}")
	elseif t == 'cc' then
		return conky_parse("${exec ./whereami_countrycode.sh}")
	else 
		return ""
	end
end

function ellipse(cx, cy, width, height)
    cairo_save (cr);

    cairo_translate (cr, cx + width*0.5, cy + height*0.5);
    cairo_scale (cr, width*0.5, height*0.5);
    cairo_arc (cr, 0.0, 0.0, 1.0, 0.0, math.pi*2.0);

    cairo_restore (cr);

    return
end

function half_upper_ellipse(cx, cy, width, height)
    cairo_save (cr);

    cairo_translate (cr, cx + width*0.5, cy + height*0.5);
    cairo_scale (cr, width*0.5, height*0.5);
    cairo_arc (cr, 0.0, 0.0, 1.0, math.pi, math.pi*2.0);

    cairo_restore (cr);

    return
end

function half_under_ellipse(cx, cy, width, height)
    cairo_save (cr);

    cairo_translate (cr, cx + width*0.5, cy + height*0.5);
    cairo_scale (cr, width*0.5, height*0.5);
    cairo_arc (cr, 0.0, 0.0, 1.0, 0.0, math.pi);


    cairo_restore (cr);

    return
end

function draw_text(cr, pos_x, pos_y, text, font_size, shift_x, shift_y)
	cairo_set_operator(cr, CAIRO_OPERATOR_SOURCE)
	cairo_set_source_rgba(cr, getColor(rgba_drawing))
	ct = cairo_text_extents_t:create()
	cairo_set_font_size(cr, font_size)
	cairo_text_extents(cr,text,ct)
	cairo_move_to(cr,pos_x-ct.width/2+shift_x,pos_y+ct.height/2+shift_y)
	cairo_show_text(cr,text)
	cairo_close_path(cr)

	return ""
end

function draw_icon(cr, pos_x, pos_y, image_path, trans)
	cairo_set_operator(cr, CAIRO_OPERATOR_OVER)
	local image = cairo_image_surface_create_from_png (image_path)
	local w_img = cairo_image_surface_get_width (image)
	local h_img = cairo_image_surface_get_height (image)

	cairo_save(cr)
	cairo_set_source_surface (cr, image, pos_x-w_img/2, pos_y-h_img/2)
	cairo_paint_with_alpha (cr, trans)
	cairo_surface_destroy (image)
	cairo_restore(cr)
	return ""
end