# Node.js toolchain: nodejs, pnpm
# pkgs: { toolchain-nodejs }

pkgs: {
  toolchain-nodejs = pkgs.symlinkJoin {
    name = "toolchain-nodejs";
    paths = [
      pkgs.nodejs
      pkgs.pnpm
    ];
  };
}
