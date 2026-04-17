function ssh-sudachi
  set arch_status (utmctl status Sudachi)

  if test $arch_status != 'started'
    echo 'Starting Sudachi...'
    utmctl start Sudachi &
    wait $last_pid
    # sleep 5
  end
  
  ssh sudachi
end
