{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [ 
    pkgs.openssl
    pkgs.pkg-config
    pkgs.awscli
    pkgs.rustfmt
    python3Packages.troposphere
    python3Packages.awacs
    python3Packages.boto3
    python3Packages.click
    python3Packages.botocore  
    pkgs.zsh
  ];
  shellHook = ''
  RUST_BACKTRACE=1
  NODE_URL='http=//0.0.0.0=8545'
  SEQUENCER_KEY='59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d'
  ENDPOINT_ADDRESS='0xa513E6E4b8f2a923D98304ec87F64353C4D5C853'
  CLEARINGHOUSE_ADDRESS='0x5FC8d32690cc91D4c39d9d3abcBD16989F875707'
  SPOT_ENGINE_ADDRESS='0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0'
  PERP_ENGINE_ADDRESS='0x9A676e781A523b5d0C0e43731313A708CB607508'
  QUERIER_ADDRESS='0x3Aa5ebB10DC797CAC828524e59A333d0A371443c'
  QUOTE_ADDRESS='0x5FbDB2315678afecb367f032d93F642f64180aa3'
  NETWORK='localhost.example'
  DB_ENGINE='postgres'
  DB_HOST='localhost'
  DB_PORT=5433
  DB_USERNAME='username'
  DB_PASSWORD='password'
  DB_NAME='vertex'
  '';
}
