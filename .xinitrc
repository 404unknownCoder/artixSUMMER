#!/bin/sh
battery="BAT0"

df_check_location='/home'

dwm_resources() {
  # get all the infos first to avoid high resources usage
  free_output=$(free -h | grep Mem)
  #df_output=$(df -h $df_check_location | tail -n 1)
  # Used and total memory
  MEMUSED=$(echo $free_output | awk '{print $3}')
  MEMTOT=$(echo $free_output | awk '{print $2}')
  # Used and total storage in /home (rounded to 1024B)
  #STOUSED=$(echo $df_output | awk '{print $3}')
  #STOTOT=$(echo $df_output | awk '{print $2}')
  #STOPER=$(echo $df_output | awk '{print $5}')
  #printf "  MEM %s / %s  STORAGE %s / %s: %s " "$MEMUSED" "$MEMTOT" "$STOUSED" "$STOTOT" "$STOPER"

  printf " MEM %s / %s" "$MEMUSED" "$MEMTOT"
}

has_battery() {
  if [ -d /sys/class/power_supply/$battery ]; then
    return 0
  fi
  return 1
}
get_battery_status() {
  charge="$(get_charge)"
  echo "( "$charge"%)"
}

get_charging_status() {
  cat "/sys/class/power_supply/$battery/status"
}

get_charge() {
  cat "/sys/class/power_supply/$battery/capacity"
}

get_datetime() {
  date +" %a %d/%m/%y  %H:%M"
}

get_status() {
  battery_status=""
  if $(has_battery); then
    battery_status="$(get_battery_status)"
  fi

  echo "$(dwm_resources) ${battery_status} $(get_datetime)"
}

while true; do
  xsetroot -name "$(get_status)"
  sleep 10
done &

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &
exec flameshot &
feh --bg-scale /home/mom/suckless/rice/wallpaper.jpg &
exec picom -b &
exec dwm
