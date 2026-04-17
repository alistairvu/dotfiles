function save-tasks
cd ~/werk/tasks
git add .
git commit -m "Sync tasks"
git push origin main
cd -
end