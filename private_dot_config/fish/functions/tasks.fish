function tasks --description 'Todo list manager'

set current_month (date +"%m")
set current_year (date +"%y")

if test "$argv" = "help"
xit --help
else if test "$argv" = "today"
xit show --status open --status ongoing -f ~/werk/tasks/{$current_year}{$current_month}_todo.xit --due-by today
else if test "$argv" = "sync"
save-tasks
else if test "$argv" = "edit"
hx  ~/werk/tasks/{$current_year}{$current_month}_todo.xit
else if test "$argv" = "claude"
cd ~/werk/tasks
claude
cd -
else if count $argv > /dev/null
xit {$argv} -f ~/werk/tasks/{$current_year}{$current_month}_todo.xit
else
xit show --status open --status ongoing -f ~/werk/tasks/{$current_year}{$current_month}_todo.xit
end
end
