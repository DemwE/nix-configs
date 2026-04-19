pkgs: {

  shell-aliases =
    mode: extras:
    let
      cmd = if mode == "legacy" then "ls" else "eza";
    in
    {
      l = "${cmd} -lFh";
      la = "${cmd} -lAFh";
      lr = "${cmd} -tRFh";
      lt = "${cmd} -ltFh";
      ll = "${cmd} -l";
    }
    // extras;

}
