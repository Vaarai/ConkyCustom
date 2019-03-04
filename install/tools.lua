function getColor(rgba)
    return rgba[1], rgba[2], rgba[3], rgba[4]
end

-- Return a color for know ssid, black for unknow ssid and 0 if not connected
function wifi_ssid_color ()
    local sh_output = io.popen("iwgetid -r")
    local ssid = sh_output:read("*a")
    sh_output:close()
    local color = {}

    if      ssid == "" then             color = 0
    --***wifi_detection_color
    else                                color = {0, 0, 0}
    end

    return color
end