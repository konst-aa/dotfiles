{ pkgs, stdenv }:
rec {
  inherit (pkgs) eggDerivation fetchegg;

  apropos = eggDerivation {
    name = "apropos-3.7.0";

    src = fetchegg {
      name = "apropos";
      version = "3.7.0";
      sha256 = "1jsbs88ks3078iv3w56s56899cfmxxb69h9v09yj5mi24fg80m8i";
    };

    buildInputs = [
      srfi-1
      utf8
      string-utils
      symbol-utils
      check-errors
    ];
  };

  breadline = eggDerivation {
    name = "breadline-0.10";

    src = fetchegg {
      name = "breadline";
      version = "0.10";
      sha256 = "1r7ygin1r1xmfgggkdg1zk1qqk3rfjcdx8b7kmrsvcaccc8ls1i4";
    };

    buildInputs = [
      pkgs.readline
      apropos
      srfi-18
    ];
  };

  check-errors = eggDerivation {
    name = "check-errors-3.6.1";

    src = fetchegg {
      name = "check-errors";
      version = "3.6.1";
      sha256 = "1nyqslc0kqwxypy7w9yvc9dr07rzzfp87xk0hiby58cz4p49sry6";
    };

    buildInputs = [
      
    ];
  };

  iset = eggDerivation {
    name = "iset-2.2";

    src = fetchegg {
      name = "iset";
      version = "2.2";
      sha256 = "0yfkcd07cw6xnnqfbbvjy81x0vc54k40vdjp2m7gwxx64is6m3rz";
    };

    buildInputs = [
      
    ];
  };

  miscmacros = eggDerivation {
    name = "miscmacros-1.0";

    src = fetchegg {
      name = "miscmacros";
      version = "1.0";
      sha256 = "0n2ia4ib4f18hcbkm5byph07ncyx61pcpfp2qr5zijf8ykp8nbvr";
    };

    buildInputs = [
      
    ];
  };

  regex = eggDerivation {
    name = "regex-2.0";

    src = fetchegg {
      name = "regex";
      version = "2.0";
      sha256 = "0qgqrrdr95yqggw8xyvb693nhizwqvf1fp9cjx9p3z80c4ih8j4j";
    };

    buildInputs = [
      
    ];
  };

  srfi-1 = eggDerivation {
    name = "srfi-1-0.5.1";

    src = fetchegg {
      name = "srfi-1";
      version = "0.5.1";
      sha256 = "15x0ajdkw5gb3vgs8flzh5g0pzl3wmcpf11iimlm67mw6fxc8p7j";
    };

    buildInputs = [
      
    ];
  };

  srfi-13 = eggDerivation {
    name = "srfi-13-0.3.3";

    src = fetchegg {
      name = "srfi-13";
      version = "0.3.3";
      sha256 = "09m424rwc76n9n9j8llhi70jjb47lfi2havpirq0rcvvgahfjwq7";
    };

    buildInputs = [
      srfi-14
    ];
  };

  srfi-14 = eggDerivation {
    name = "srfi-14-0.2.1";

    src = fetchegg {
      name = "srfi-14";
      version = "0.2.1";
      sha256 = "0gc33cx4xll9vsf7fm8jvn3gc0604kn3bbi6jfn6xscqp86kqb9p";
    };

    buildInputs = [
      
    ];
  };

  srfi-18 = eggDerivation {
    name = "srfi-18-0.1.6";

    src = fetchegg {
      name = "srfi-18";
      version = "0.1.6";
      sha256 = "00lykm5lqbrcxl3dab9dqwimpgm36v4ys2957k3vdlg4xdb1abfa";
    };

    buildInputs = [
      
    ];
  };

  srfi-69 = eggDerivation {
    name = "srfi-69-0.4.3";

    src = fetchegg {
      name = "srfi-69";
      version = "0.4.3";
      sha256 = "11pny54nc3rpmpaxcxs9dap1n6490y80zpwgfg0bwji1938a6fks";
    };

    buildInputs = [
      
    ];
  };

  string-utils = eggDerivation {
    name = "string-utils-2.6.0";

    src = fetchegg {
      name = "string-utils";
      version = "2.6.0";
      sha256 = "0nmw3gyi7z3svfqf9wjgy0p3sy6dia7ibynsm9mrzzssd7k39rk2";
    };

    buildInputs = [
      utf8
      srfi-1
      srfi-13
      srfi-69
      miscmacros
      check-errors
    ];
  };

  symbol-utils = eggDerivation {
    name = "symbol-utils-2.3.0";

    src = fetchegg {
      name = "symbol-utils";
      version = "2.3.0";
      sha256 = "00v37a80irifk0gkz2wayii1blljzd2xrrf1ljmr7qqqnfn2c05j";
    };

    buildInputs = [
      utf8
    ];
  };

  utf8 = eggDerivation {
    name = "utf8-3.6.3";

    src = fetchegg {
      name = "utf8";
      version = "3.6.3";
      sha256 = "1g41dlbnfgwkfllci7gfqfckfdz0nm5zbihs6vi3rdsjwg17g7iw";
    };

    buildInputs = [
      srfi-69
      iset
      regex
    ];
  };
}

