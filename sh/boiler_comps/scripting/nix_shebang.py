def run():
    interpreter = input("What interpreter?\n")
    packages = input("What packages? (space-separated)\n")
    return f"""
#!/usr/bin/env nix-shell
#! nix-shell --pure -i {interpreter} -p {packages}
"""
