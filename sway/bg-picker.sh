hostname=$(hostnamectl | head -n 1 | cut -f 4,4 -d " ")

case $hostname in
    mindstone | mopalonarch)
        echo "$HOME/dotfiles/desktop-images/anvil-upscaled-2x.jpg"
        ;;
esac

