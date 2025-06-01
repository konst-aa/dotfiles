{ config, modulesPath, lib, pkgs, ... }:
  let
    hypermail = pkgs.callPackage ./hypermail.nix {  };
      # (builtins.getFlake "github:konst-aa/dotfiles").packages.x86_64-linux.hypermail;
    hypermailrc = builtins.toFile "hmrc" ''
reverse = 1
showhtml = 2
antispam_at = @

hm_hmail = dinner@dreadmaw.industries
'';
    auto-hypermail =
      pkgs.stdenv.mkDerivation rec {
      buildInputs = [ pkgs.makeWrapper ];
      name = "auto-hypermail";
      version = "0.0.0";

      script = ''
#!/bin/bash
# check for update on /var/mail/dinner

prev=""

while true; do
    if [[ $(ls -l /var/mail/dinner | awk '{print $6,$7,$8}')  == "$prev" ]]; then
        sleep 3
    else
        prev=$(ls -l /var/mail/dinner | awk '{print $6,$7,$8}')
        echo $(date) "Upating archive..."
        [ -d /tmp/dinner ] || mkdir /tmp/dinner
        cd /tmp/dinner
        rm -r archive
        cat /var/mail/dinner | hypermail -l "dinner" -c ${hypermailrc}
        rm /var/www/html/*
        cp archive/* /var/www/html/
        echo $(date) "Done."
    fi
done
      '';
      src = builtins.storePath (builtins.toFile "auto-hypermail.sh" script);
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/bin
	cp $src $out/bin/auto-hypermail.sh
	chmod +x $out/bin/auto-hypermail.sh
	wrapProgram $out/bin/auto-hypermail.sh \
            --prefix PATH : ${lib.makeBinPath [ pkgs.coreutils pkgs.gawk hypermail ]}
      '';
    };

  in
{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh = {
    enable = true;
# require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      GatewayPorts = "yes";
    };
  };

  environment.systemPackages = [
    pkgs.neovim
    pkgs.python3
    hypermail
    auto-hypermail
  ];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 25 443 6000 ];
  };

  systemd.services.auto-hypermail = {
    enable = true;
    # after = [];
    wantedBy = [ "multi-user.target" ];
    description = "Automatically archives the emails of the dinner user";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${auto-hypermail}/bin/auto-hypermail.sh";
      User = "root";
    };
  };

  users.users.dinner = {
    isNormalUser = true;
    home = "/home/dinner";
    description = "for the dinner";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keyFiles = [
      # "/home/dinner/.authorized_keys"
    ];
  };
  users.users.postfix.extraGroups = [ "acme" ];
  services.nginx.enable = true;
  services.nginx.virtualHosts = {
    "dinner.dreadmaw.industries" = {
      basicAuth = { person = "opensesameavocados"; };
 # forceSSL = true;
      enableACME = true;
      root = "/var/www/html";
    };
    "acmechallenge.dreadmaw.industries" = {
# Catchall vhost, will redirect users to HTTPS for all vhosts
      serverAliases = [ "*.dreadmaw.industries" ];
      locations."/.well-known/acme-challenge" = {
        root = "/var/lib/acme/.challenges";
      };
      locations."/" = {
        return = "301 https://$host$request_uri";
      };
    };
  };
# https://nixos.org/manual/nixos/stable/index.html#module-security-acme
   security.acme = {
     acceptTerms = true;
     defaults.email = "konstantin.astafurov@gmail.com";
     certs."dinner.dreadmaw.industries" = {
       webroot = "/var/lib/acme/.challenges";
       group = "nginx";
       extraDomainNames = [ "mail.dreadmaw.industries" ];
     };
   };

  services.spamassassin.enable = true;
  services.postfix = {
    enable = true;
    sslCert = config.security.acme.certs."dinner.dreadmaw.industries".directory + "/full.pem";
    sslKey = config.security.acme.certs."dinner.dreadmaw.industries".directory + "/key.pem";
    domain = "dreadmaw.industries";
    destination = [ "$myhostname" "$mydomain" "localhost" ];
    hostname = "mail.dreadmaw.industries";
    extraConfig = ''

      # EXTRA CONFIG!!

      smtpd_relay_restrictions = 
          permit_mynetworks permit_sasl_authenticated defer_unauth_destination

      smtpd_recipient_restrictions =
          check_sender_access texthash:${./sender_access},
          reject_unknown_sender_domain,
          reject_sender_login_mismatch,
          reject_unauthenticated_sender_login_mismatch,
          reject

    '';
  config = {
    smtpd_sasl_auth_enable = "yes";
    mail_spool_directory = "/var/spool/mail";
  };
  };

  services.fail2ban = {
    enable = true;
    # enable = false;
    maxretry = 8;
  };

  system.stateVersion = "23.11";
}
