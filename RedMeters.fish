#!/usr/bin/env fish
# * All Github Scripting Goes Here
function SetupRedMetersGithub -d "Setup Redmeters Dev Environment"
set git_dir "/Users/ahmed/work"
    # On First Time Maybe Include it in Config.fish file 
    set repo_list "analyzer" "automation" "cinder-common" "device-image" "DeviceFrontEnd" "DeviceBackend" "DevOps" "ember_identity" "PartnerPortal" "PartnerPortalBackend" "Playground" "Cloud"
    for git_repo in repo_list
        cd $get_dir
        git clone https://github.com/RedMeters/$git_repo
        cd $git_repo
        for abranch in $(git branch -a | grep -v HEAD | grep remotes | sed "s/remotes\/origin\///g"); 
            git checkout $abranch; 
        end
        git checkout main   
    end
end

function PullFromRedMetersGithub -d "Pulls Latest From All Branches and Repos"
set git_dir "/Users/ahmed/work"
    set repo_list "analyzer" "automation" "cinder-common" "device-image" "DeviceFrontEnd" "DeviceBackend" "DevOps" "ember_identity" "PartnerPortal" "PartnerPortalBackend" "Playground" "Cloud"
    for git_repo in $repo_list
        if test -d "$git_dir/$git_repo"
            cd "$git_dir/$git_repo" &&
            # echo "Pulling from"; set_color red; echo $git_dir/$git_repo; set_color normal &&
            git pull --all --ff-only &&
            clear && printf '\e[3J'
            echo -n "Pulled "; set_color green; echo $git_repo; set_color normal
        else
            echo "Did not find the repo $git_repo. Attempting to clone it now..."
            cd $git_dir
            git clone https://github.com/RedMeters/$git_repo
            cd $git_repo
            for abranch in $(git branch -a | grep -v HEAD | grep remotes | sed "s/remotes\/origin\///g")
                git checkout $abranch 
            end
            git checkout main
            echo "Cloned $git_repo."
        end
    end
    clear && printf '\e[3J'
    echo "✓ Completed Successfully ✓"
    sleep 2
    clear && printf '\e[3J'
    cd ~/work
end

function TimedPullFromRedMetersGithub -d "Times the Pull"
  set START_TS (date +%s)

  sleep 5
  PullFromRedMetersGithub

  set END_TS (date +%s)
  set RUNTIME (math $END_TS - $START_TS)
  set RUNTIME (math $RUNTIME / 60)
  echo "⏲  Total runtime: $RUNTIME min ⏲"
  sleep 3
  clear
end
#####################################################################################################################
# * Helper Functions Goes Here
function ConnectToNewHardWare -d "Connect o IMX8M Board Via Usb"
    echo "🟢 Connecting to IMX8M Board 🟢"
    screen /dev/tty.usbserial-02780035 115200,cs8,-parenb,-cstopb,-hupcl
    echo "🔴 Connection Terminated 🔴"
end


funcsave TimedPullFromRedMetersGithub
funcsave PullFromRedMetersGithub
funcsave SetupRedMetersGithub
funcsave ConnectToNewHardWare

