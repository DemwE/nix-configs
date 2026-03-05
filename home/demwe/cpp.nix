# Pre-seed CLion toolchains.xml so it detects only ~/.toolchains/cpp — nothing from system.
# Analogous to java.nix (which creates ~/.jdks/ symlinks for IDEA auto-detection).
#
# CLion stores toolchains per OS in  ~/.config/JetBrains/CLion<version>/options/linux/toolchains.xml
# The version in the directory name changes each major release, so home.activation is used
# instead of a static home.file path — it finds all CLion* directories at activation time.
#
# $USER_HOME$ is CLion's own path macro (not a shell variable); keep it literal in the XML.

{ lib, ... }:
{
  home.activation.clionToolchains = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for optionsDir in "$HOME"/.config/JetBrains/CLion*/options; do
      [ -d "$optionsDir" ] || continue
      mkdir -p "$optionsDir/linux"
      cat > "$optionsDir/linux/toolchains.xml" << 'EOF'
<application>
  <component name="CPPToolchains" version="10">
    <toolchains detectedVersion="5">
      <toolchain name="Nix"
        toolSetKind="CUSTOM_TOOLSET"
        customCMakePath="$USER_HOME$/.toolchains/cpp/bin/cmake"
        customMakePath="$USER_HOME$/.toolchains/cpp/bin/make"
        customCCompilerPath="$USER_HOME$/.toolchains/cpp/bin/gcc"
        customCXXCompilerPath="$USER_HOME$/.toolchains/cpp/bin/g++"
        debuggerKind="CUSTOM_GDB"
        customGDBPath="$USER_HOME$/.toolchains/cpp/bin/gdb" />
    </toolchains>
  </component>
</application>
EOF
    done
  '';
}
