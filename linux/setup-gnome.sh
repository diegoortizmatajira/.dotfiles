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
  gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>$NORMALIZED_I', '<Super>KP_$NORMALIZED_I']"
  # Bind Super + n to move a window to a workspace
  gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "['<Super><Shift>$NORMALIZED_I', '<Super><Shift>KP_$NORMALIZED_I']"
done

gsettings set "org.gnome.desktop.wm.keybindings" "toggle-maximized" "['<Super>m', '<Alt>F10']"

package_list=(
  gnome-shell-extension-dash-to-panel 
  gnome-shell-extension-pop-shell-git
  gnome-shell-extension-appindicator-git 
  gnome-shell-extension-caffeine
  gnome-shell-pomodoro
  apple_cursor
)

yay -S ${package_list[@]} --needed 
