{ lib, stdenv, fetchFromGitHub, gcc, gnumake, yacc, gdbm, usegdbm ? true, configureFlags ? [ ] }:
let
  _configureFlags = (if usegdbm then "" else "--without-gdbm") + (lib.concatStringsSep " " configureFlags);
in
stdenv.mkDerivation rec {
  name = "hypermail";
  version = "2.4.0";
  src = fetchFromGitHub {
    owner = "hypermail-project";
    repo = "hypermail";
    rev = "v${version}";
    hash = "sha256-K1o6HlSu7xivNlQdKtcAEtIa/23YybJQssvgH+wrBgA=";
  };
  buildInputs = [ gcc gnumake yacc ] ++ (if usegdbm then [ gdbm ] else [ ]);
  # weird locale warning that doesn't seem to affect anything
  # nativeBuildInputs = [ locale ];
  configurePhase = ''
    ./configure ${_configureFlags} --prefix=$out
  '';
  # buildPhase = ''
  #   make
  # '';
  installPhase = ''
    mkdir -p $out/bin
    cp src/hypermail $out/bin
  '';
  meta = with lib; {
    homepage = "https://www.hypermail-project.org/";
    description = "Hypermail is a free (GPL) program to convert email from Unix mbox format to html.";
    platforms = platforms.all;
    license = licenses.gpl2;
    maintainers = with maintainers; [
      konst-aa
    ];
    mainProgram = "hypermail";
  };
}

