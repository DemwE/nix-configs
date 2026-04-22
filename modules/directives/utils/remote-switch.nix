# custom.remote-switch
pkgs: {
  remote-switch = pkgs.writeShellApplication {
    name = "remote-switch";
    runtimeInputs = [ pkgs.custom.switch ]; 
    text = ''
      if [ "$#" -lt 2 ]; then
        echo "Usage: remote-switch <hostname> <build-host>"
        exit 1
      fi

      HOST="$1"
      BUILD_HOST="$2"

      echo "Redirecting build of $HOST to $BUILD_HOST"

      switch "$HOST" \
        --build-host "$BUILD_HOST" \
        --option max-jobs 0 \
        --option builders "ssh://$BUILD_HOST?max-jobs=auto"
    '';
  };
}