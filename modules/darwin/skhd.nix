{ pkgs, ... }: {

services.skhd = {
  enable = true;
  skhdConfig = ''
    lalt - return : open -n -a iTerm

    lalt - 1 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[0]} ]] && yabai -m space --focus ''${SPACES[0]}'
    lalt - 2 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[1]} ]] && yabai -m space --focus ''${SPACES[1]}'
    lalt - 3 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[2]} ]] && yabai -m space --focus ''${SPACES[2]}'

    lalt - q : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[3]} ]] && yabai -m space --focus ''${SPACES[3]}'
    lalt - w : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[4]} ]] && yabai -m space --focus ''${SPACES[4]}'
    lalt - e : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[5]} ]] && yabai -m space --focus ''${SPACES[5]}'

    lalt - f : yabai -m window --toggle float

    shift + lalt - j : bash -c 'yabai -m window --warp west || (yabai -m window --display west && yabai -m display --focus west && yabai -m window --warp last) || yabai -m window --move rel:-10:0'
    shift + lalt - k : bash -c 'yabai -m window --warp south || (yabai -m window --display south && yabai -m display --focus south) || yabai -m window --move rel:0:10'
    shift + lalt - i : bash -c 'yabai -m window --warp north || (yabai -m window --display north && yabai -m display --focus north) || yabai -m window --move rel:0:-10'
    shift + lalt - l : bash -c 'yabai -m window --warp east || (yabai -m window --display east && yabai -m display --focus east && yabai -m window --warp first) || yabai -m window --move rel:10:0'

    shift + lalt - s : yabai -m window --toggle split

    shift + lalt - 1 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[0]} ]] && yabai -m window --space ''${SPACES[0]}'
    shift + lalt - 2 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[1]} ]] && yabai -m window --space ''${SPACES[1]}'
    shift + lalt - 3 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[2]} ]] && yabai -m window --space ''${SPACES[2]}'
    shift + lalt - 4 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[3]} ]] && yabai -m window --space ''${SPACES[3]}'
    shift + lalt - 5 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[4]} ]] && yabai -m window --space ''${SPACES[4]}'
    shift + lalt - 6 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[5]} ]] && yabai -m window --space ''${SPACES[5]}'
    shift + lalt - 7 : bash -c 'SPACES=($(yabai -m query --displays --display | jq ".spaces[]")); [[ -n ''${SPACES[6]} ]] && yabai -m window --space ''${SPACES[6]}'

    shift + lalt - p : yabai -m window --space prev && yabai -m space --focus prev
    shift + lalt - n : yabai -m window --space next && yabai -m space --focus next

    shift + lalt - x : yabai -m space --mirror x-axis
    shift + lalt - y : yabai -m space --mirror y-axis

    shift + ctrl - j : yabai -m window west --stack $(yabai -m query --windows --window | jq -r '.id')
    shift + ctrl - k : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id')
    shift + ctrl - l : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id')
    shift + ctrl - o : yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id')

    shift + ctrl - n : yabai -m window --focus stack.next
    shift + ctrl - p : yabai -m window --focus stack.prev

    ctrl + lalt - e : yabai -m space --balance
    ctrl + lalt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

    shift + ctrl + lalt - j : yabai -m window --insert west
    shift + ctrl + lalt - k : yabai -m window --insert south
    shift + ctrl + lalt - l : yabai -m window --insert north
    shift + ctrl + lalt - o : yabai -m window --insert east
    shift + ctrl + lalt - s : yabai -m window --insert stack

    lalt - s : yabai -m window --insert east; skhd -k "cmd - n"
    lalt - v : yabai -m window --insert south; skhd -k "cmd - n"

    shift + lalt - space : sketchybar --bar hidden=toggle
  '';
};

}