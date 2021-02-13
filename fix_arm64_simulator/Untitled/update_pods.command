#exit script immediately if any command returns a non-zero exit code (indicating an error)
set -o errexit

#cd to the directory this file is in
DIRECTORY=$(dirname "$0")
cd "$DIRECTORY"

#Text coloring functions
function color {
    if tty -s
    then
        tput setaf $2
        echo "$1"
        tput setaf 0
        return
    fi
    
    echo "$1"
}

function red {
    color "$1" 1
}

function green {
    color "$1" 2
}

green "Deleting Podfile.lock..."
touch Podfile.lock
rm Podfile.lock

green "Deintegrating..."
pod deintegrate

green "Clearing cache..."
pod cache clean --all

green "Updating repo..."
arch -x86_64 pod repo update

green "Installing pods..."
arch -x86_64 pod install

say "Done installing pods"



