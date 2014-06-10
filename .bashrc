# ~/.bashrc to start docker on login and kill it on exit.

if ! /etc/init.d/docker status >/dev/null 2>&1
then
  docker_shutdown() {
    sudo /etc/init.d/docker stop
  }

  sudo /etc/init.d/docker start
  trap docker_shutdown EXIT
fi
