#!/usr/bin/env fish
function OpenVSCodeIn -a dir subdir -d "Get the working directory"
    if string match -q "personal" $dir
        set dirList
        for locatedDir in (find ~/$dir -type d -maxdepth 1)
            if string match -q "/Users/ahmed/$dir/$subdir" $locatedDir
                echo -n "🟢 Directory:"; set_color green; echo -n " $subdir "; set_color normal; echo "Found 🟢"
                cd ~/$dir/$subdir
                code .
                return    
            end
        end
        echo "🔴 $subdir not found run [ WhatDoWeHave work ] to see all availible directories🔴"      
    else if string match -q "work" $dir
        set dirList
        for locatedDir in (find ~/$dir -type d -maxdepth 1)
            if string match -q "/Users/ahmed/$dir/$subdir" $locatedDir
                echo -n "🟢 Directory:"; set_color green; echo -n " $subdir "; set_color normal; echo "Found 🟢"
                cd ~/$dir/$subdir
                code .
                return    
            end
        end
        echo "🔴 $subdir not found run [ WhatDoWeHave work ] to see all availible directories🔴"  
    else 
        echo "🔴 Operation Not Permitted Please Select Either [personal] or [work] 🔴"
    end
end

function ListDirsIn -a dir -d "Lists All Availible Direcotries in either work or personal mode"
    if string match -q "personal" $dir
        echo -n "🟢 Personal Directories: "; set_color green; echo "Found 🟢"; set_color normal;
        set_color red; echo "===================================="; set_color normal;
        for locatedDir in (find ~/$dir -type d -maxdepth 1)
            set_color blue; echo -n "==> "; set_color normal; echo (basename $locatedDir);
        end
        set_color red; echo "===================================="; set_color normal;
    else if string match -q "work" $dir
        echo -n "🟢 Work Directories: "; set_color green; echo "Found 🟢"
        set_color red; echo "===================================="; set_color normal;
        for locatedDir in (find ~/$dir -type d -maxdepth 1)
            set_color blue; echo -n "==> "; set_color normal; echo (basename $locatedDir);
        end
        set_color red; echo "===================================="; set_color normal;
    else
        echo "🔴 Operation Not Permitted Please Select Either [personal] or [work] 🔴"
        find ~/$dir -type d -maxdepth 1
    end
end


function KillYourSelf -d "Kill Your Self"
    echo "🔴 Killing Your Self 🔴"
    kill -9 $fish_pid
end



funcsave ListDirsIn
funcsave OpenVSCodeIn
funcsave KillYourSelf
