pkgs: {

  shell-aliases =
    mode: extras:
    let
      legacy = "ls";
      eza = "eza --icons";
      baseAliases =
        if mode == "legacy" then
          {
            l = "${legacy} -lh";
            la = "${legacy} -lAh";
            lr = "${legacy} -lR";
            lt = "${legacy} -lth";
            ll = "${legacy} -l";
          }
        else
          {
            l = "${eza} -l";
            la = "${eza} -la";
            lr = "${eza} -lR";
            lt = "${eza} -lt";
            ll = "${eza} -l";
          };
    in
    baseAliases // extras;

}
