{ my, lib, ... }:
let p = my.theme.palette; accent = my.theme.accent; in lib.mkIf my.features.hyprland.enable {
  programs.wlogout = {
    enable = true;
    style = ''
      @define-color base ${p.base};
      @define-color surface0 ${p.surface0};
      @define-color surface1 ${p.surface1};
      @define-color surface2 ${p.surface2};
      @define-color text ${p.text};
      @define-color accent ${p.${accent}};
      @define-color red ${p.red};
      @define-color green ${p.green};
      @define-color yellow ${p.yellow};

      window { background-color: alpha(@base,0.94); }
      button { color:@text; background:@surface0; border:2px solid @surface2; border-radius:22px; margin:18px; padding:34px; font-size:22px; }
      button:hover { background:@surface1; border-color:@accent; }
      button:focus { box-shadow:0 0 0 3px alpha(@accent,0.35); }
      #lock { border-color:@accent; }
      #logout { border-color:@yellow; }
      #suspend { border-color:@green; }
      #hibernate { border-color:@surface2; }
      #reboot { border-color:@yellow; }
      #shutdown { border-color:@red; }
    '';
  };
}
