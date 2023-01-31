# Setup Fixed workspaces
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10
# unbind Switch to Application keybindings
for i in {1..9} 
do
  gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
done
for i in {1..10} 
do
  NORMALIZED_I=$(($i%10))
  # Bind Super + n to switch to a workspace
  gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>$NORMALIZED_I']"
  # Bind Super + n to move a window to a workspace
  gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "['<Super><Shift>$NORMALIZED_I']"
done
