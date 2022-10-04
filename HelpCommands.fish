#!/usr/bin/env fish
function OpenVSCodeIn -a dir -d "Get the working directory"
    if string match -q "personal" $dir
        cd ~/personal
        clear
        code .
    end

    if string match -q "work" $dir
        cd ~/work
        clear
        code .

    else 
        echo "🔴 Operation Not Permitted Please Select Either [personal] or [work] 🔴"
    end
end

funcsave OpenVSCodeIn
