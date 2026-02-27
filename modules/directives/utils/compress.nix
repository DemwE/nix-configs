# compress & decompress package definitions
# pkgs: { compress, decompress }

pkgs: {

  compress = pkgs.writeShellApplication {
    name = "compress";
    runtimeInputs = [ pkgs.gnutar pkgs.zstd ];
    text = ''
      if [ "$#" -ne 2 ]; then
        echo "Usage: compress <source> <output>"
        exit 1
      fi
      SOURCE=$1
      OUTPUT=$2
      if [[ ! "$OUTPUT" =~ \.tar\.zst$ ]]; then
        OUTPUT="$OUTPUT.tar.zst"
      fi
      echo "Executing: tar -I zstd -cvf \"$OUTPUT\" \"$SOURCE\""
      tar -I zstd -cvf "$OUTPUT" "$SOURCE"
    '';
  };

  decompress = pkgs.writeShellApplication {
    name = "decompress";
    runtimeInputs = [ pkgs.gnutar pkgs.zstd ];
    text = ''
      if [ "$#" -ne 2 ]; then
        echo "Usage: decompress <archive> <output-dir>"
        exit 1
      fi
      ARCHIVE=$1
      OUTPUT_DIR=$2
      if [[ ! "$ARCHIVE" =~ \.tar\.zst$ ]]; then
        ARCHIVE="$ARCHIVE.tar.zst"
      fi
      echo "Executing: tar -I zstd -xvf \"$ARCHIVE\" -C \"$OUTPUT_DIR\""
      tar -I zstd -xvf "$ARCHIVE" -C "$OUTPUT_DIR"
    '';
  };

}