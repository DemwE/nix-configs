{ pkgs, lib, config, ... }:
let
  hasNvidiaFgpm = config.my.features.nvidia.finegrainedPowerManagement or false;

  mkPowerScript = name: body: pkgs.writeShellScriptBin name ''
    set -euo pipefail
    if [[ $EUID -ne 0 ]]; then
      exec sudo "$0" "$@"
    fi
    ${body}
  '';

  # ── Power Saver ───────────────────────────────────────────────────────────────
  powerSave = mkPowerScript "power-save" ''
    echo "==> Power Saver"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo powersave > "$cpu"
    done
    if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
      echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
    fi
    ${lib.optionalString hasNvidiaFgpm ''
    for dev in /sys/bus/pci/devices/*/power/control; do
      echo auto > "$dev" 2>/dev/null || true
    done
    ''}
    echo "   CPU: powersave, turbo: off${lib.optionalString hasNvidiaFgpm ", NVIDIA: D3cold"}"
  '';

  # ── Balanced ──────────────────────────────────────────────────────────────────
  balanced = mkPowerScript "power-balanced" ''
    echo "==> Balanced"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo schedutil > "$cpu" 2>/dev/null || echo powersave > "$cpu"
    done
    if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
      echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
    fi
    ${lib.optionalString hasNvidiaFgpm ''
    for dev in /sys/bus/pci/devices/*/power/control; do
      echo auto > "$dev" 2>/dev/null || true
    done
    ''}
    echo "   CPU: schedutil, turbo: auto${lib.optionalString hasNvidiaFgpm ", NVIDIA: runtime auto"}"
  '';

  # ── Performance ───────────────────────────────────────────────────────────────
  performance = mkPowerScript "power-performance" ''
    echo "==> Performance"
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
      echo performance > "$cpu"
    done
    if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
      echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo
    fi
    ${lib.optionalString hasNvidiaFgpm ''
    for dev in /sys/bus/pci/devices/*/power/control; do
      echo on > "$dev" 2>/dev/null || true
    done
    ''}
    echo "   CPU: performance, turbo: on${lib.optionalString hasNvidiaFgpm ", NVIDIA: always on"}"
  '';

  # ── Status ────────────────────────────────────────────────────────────────────
  powerStatus = pkgs.writeShellScriptBin "power-status" ''
    echo "── Active PPD profile ──"
    ${pkgs.glib}/bin/gdbus call --system \
      --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles \
      --method org.freedesktop.DBus.Properties.Get \
      net.hadess.PowerProfiles ActiveProfile 2>/dev/null || echo "(PPD not running)"

    echo ""
    echo "── CPU governors ──"
    grep . /sys/devices/system/cpu/cpu{0,1,2,3}/cpufreq/scaling_governor 2>/dev/null | head -4

    echo ""
    echo "── Turbo ──"
    if [[ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]]; then
      no_turbo=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)
      [[ "$no_turbo" == "1" ]] && echo "off" || echo "on"
    fi

    ${lib.optionalString hasNvidiaFgpm ''
    echo ""
    echo "── NVIDIA power control ──"
    for dev in /sys/bus/pci/devices/*/power/control; do
      vendor=$(cat "$(dirname "$dev")/vendor" 2>/dev/null || true)
      if [[ "$vendor" == "0x10de" ]]; then
        echo "$dev -> $(cat "$dev")"
      fi
    done
    ''}
  '';

  # ── D-Bus hook script (runs as root, reacts to GNOME profile changes) ─────────
  ppdHookScript = pkgs.writeShellScript "ppd-hook" ''
    set -euo pipefail
    export PATH=${lib.makeBinPath [ pkgs.glib pkgs.gnugrep pkgs.coreutils ]}:$PATH

    apply_profile() {
      local profile="$1"
      case "$profile" in
        power-saver)  ${powerSave}/bin/power-save ;;
        balanced)     ${balanced}/bin/power-balanced ;;
        performance)  ${performance}/bin/power-performance ;;
      esac
    }

    # Apply current profile once on service start
    current=$(gdbus call --system \
      --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles \
      --method org.freedesktop.DBus.Properties.Get \
      net.hadess.PowerProfiles ActiveProfile 2>/dev/null \
      | grep -oP "(?<=<')[^']+" || echo "balanced")
    echo "[ppd-hook] startup profile: $current"
    apply_profile "$current"

    # Watch for profile changes emitted by PPD via D-Bus
    gdbus monitor --system \
      --dest net.hadess.PowerProfiles \
      --object-path /net/hadess/PowerProfiles 2>/dev/null \
    | while IFS= read -r line; do
        if echo "$line" | grep -q "ActiveProfile"; then
          profile=$(echo "$line" | grep -oP "(?<=<')[^']+")
          echo "[ppd-hook] profile changed → $profile"
          apply_profile "$profile"
        fi
      done
  '';
in
{
  # Use power-profiles-daemon so GNOME's panel integration works
  services.power-profiles-daemon.enable = true;

  # Systemd service that hooks into PPD D-Bus signals and applies custom logic
  systemd.services.ppd-hook = {
    description = "Custom power profile hooks (NVIDIA, turbo) on top of PPD";
    after = [ "power-profiles-daemon.service" "dbus.service" ];
    wants = [ "power-profiles-daemon.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "on-failure";
      RestartSec = "3s";
      ExecStart = ppdHookScript;
    };
  };

  environment.systemPackages = [ powerSave balanced performance powerStatus ];

  # Allow wheel users to run scripts without password
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = map (script: {
        command = "${script}/bin/${script.name}";
        options = [ "NOPASSWD" ];
      }) [ powerSave balanced performance ];
    }
  ];
}
