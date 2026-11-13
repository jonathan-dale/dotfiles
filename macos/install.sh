if test ! "$(uname)" = "Darwin"
  then
  exit 0
fi

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.
#
# This can take a long time, so ask first. script/install pipes `find` into this
# script's stdin, so the answer has to come from the terminal (/dev/tty), not
# stdin. With no terminal (e.g. unattended runs) we skip rather than block.

run_softwareupdate=false
if { : < /dev/tty > /dev/tty; } 2>/dev/null; then
  printf "  [ ?? ] Run macOS softwareupdate? This can take a while. [y/N]: " > /dev/tty
  read -r reply < /dev/tty
  case "$reply" in
    [yY]|[yY][eE][sS]) run_softwareupdate=true ;;
  esac
fi

if [ "$run_softwareupdate" = true ]; then
  echo "› sudo softwareupdate -i -a"
  sudo softwareupdate -i -a
else
  echo "› skipping softwareupdate (run 'sudo softwareupdate -i -a' later if needed)"
fi
