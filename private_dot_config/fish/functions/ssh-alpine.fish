function ssh-alpine
  set alpine_status (utmctl status Alpine)

  if test $alpine_status != 'started'
    echo 'Starting Alpine...'
    utmctl start Alpine &
    wait $last_pid
    sleep 5
  end
  
  ssh alpine
end
