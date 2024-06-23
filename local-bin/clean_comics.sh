TARGET=${1:-"."}
for f in "$TARGET"/*.cbz;
do
    zip -d $f "*_0.*" "*GCPD*Guy*.*" "*Insomniacs*.*"
done
