local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Omega248/os-policegarage/main/version', function(err, newestVersion, headers)
        if err ~= 200 then
            print("HTTP Request Error. Error code: " .. tostring(err))
            return
        end

        if newestVersion == nil or newestVersion == "" then
            print("Failed to retrieve the latest version. The response was empty.")
            return
        end

        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version'):gsub("%s+", "")
        newestVersion = newestVersion:gsub("%s+", "")

        if newestVersion == currentVersion then
            return
        else 
            print("^1You are running an outdated version of " .. GetCurrentResourceName() .. ".^7")
            print("Current Version: " .. currentVersion .. ", Latest Version: " .. newestVersion)
            print("Please download the latest version from: https://github.com/Omega248/os-policegarage/releases")
        end
    end, 'GET')
end
CheckVersion()
