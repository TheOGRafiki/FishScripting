#!/usr/bin/env fish

function GetWorkingDir -a dir -d "Get the current working directory"
    if string match -q "personal" $dir
        cd ~/work/personal
        code .
    end

    if string match -q "work" $dir
        cd ~/work
        code .
    end


funcsave GetWorkingDir
