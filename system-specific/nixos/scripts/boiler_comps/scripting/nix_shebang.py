def run():
    print("Packages and environment variables are SPACE SEPARATED")
    env = input("Any environment variables?\n")
    env = env + " " if env else env
    interpreter = input("What interpreter?\n")
    packages = input("What packages?\n")
    return f"""#!/usr/bin/env nix-shell
#! nix-shell --pure --keep {env}-i {interpreter} -p {packages}
"""
