# Battery monitoring utilities
# pkgs: { battery-watch, battery-info }

pkgs: {

  battery-watch = pkgs.writeShellApplication {
    name = "battery-watch";
    runtimeInputs = [ pkgs.procps ];
    text = ''
      watch -n 1 "cat /sys/class/power_supply/BAT0/power_now | awk '{print \$1/1000000 \" W\"}'"
    '';
  };

  battery-info = pkgs.writeShellApplication {
    name = "battery-info";
    runtimeInputs = [ pkgs.bc ];
    text = ''
      NOW=$(cat /sys/class/power_supply/BAT0/energy_now)
      FULL=$(cat /sys/class/power_supply/BAT0/energy_full)
      POWER=$(cat /sys/class/power_supply/BAT0/power_now)
      STATUS=$(cat /sys/class/power_supply/BAT0/status)
      PCT=$(( NOW * 100 / FULL ))
      WATTS=$(echo "scale=2; $POWER / 1000000" | bc)
      echo "Status:        $STATUS"
      echo "Level:         $PCT%"
      if [ "$STATUS" = "Discharging" ] && [ "$POWER" -gt 0 ]; then
        REMAINING_H=$(echo "scale=2; $NOW / $POWER" | bc)
        FULL_H=$(echo "scale=2; $FULL / $POWER" | bc)
        echo "Power draw:    ''${WATTS}W"
        echo "Remaining:     ''${REMAINING_H}h"
        echo "At full:       ''${FULL_H}h"
      elif [ "$STATUS" = "Charging" ] && [ "$POWER" -gt 0 ]; then
        CHARGE_H=$(echo "scale=2; ($FULL - $NOW) / $POWER" | bc)
        echo "Charging at:   ''${WATTS}W"
        echo "Full in:       ''${CHARGE_H}h"
      else
        echo "Power:         ''${WATTS}W"
      fi
    '';
  };

}
