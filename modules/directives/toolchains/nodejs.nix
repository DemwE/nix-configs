# Node.js toolchain: pnpm
# pkgs: { toolchain-nodejs }
# Node.js versions exposed via ~/.nvm/versions/node/ (home/demwe/nodejs.nix)

pkgs: {
  toolchain-nodejs = pkgs.symlinkJoin {
    name = "toolchain-nodejs";
    paths = [
      pkgs.unstable.pnpm
      pkgs.nodejs_24
      pkgs.unstable.bun
    ];
  };
}
