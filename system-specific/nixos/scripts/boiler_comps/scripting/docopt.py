__doc__ = """Script

Usage:
  script (-h | --help)
  script --version

Options:
  (-h | --help)     Show this screen.
  --version         Show version.

"""
from docopt import docopt
import os


if __name__ == "__main__":
    args = docopt(__doc__, version="Script 0.1")
