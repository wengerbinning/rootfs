BEGIN { if (!src || !dst) { printf "please set src & dst !\n";
    printf " Ex: awk -f install.awk -vsrc=src -vdst=dst pkg-list\n"
exit } else printf "# %s -> %s\n", src, dst}
{ if ($1 ~ /^#.*/) next }
{ if (NF == 0) next }
{ if (NF == 3 && $2 == "->") { "dirname "$1 | getline path; close(cmd)
    if (0 == system("test ! -d "dst"/"path)) {
        system("install -m 755 -d "dst"/"path)
        printf "install -m 755 -d %s/%s;\n", dst, path
    }
    system("ln -sf "$3" "dst"/"$1)
    printf "ln -sf %s %s/%s;\n", $3, dst, $1
next }}
{ if ($1 ~ /^.*\/$/) { if (0 == system("test ! -d "dst"/"$1)) {
    system("install -m 755 -d "dst"/"$1)
    printf "install -m 755 -d %s/%s;\n", dst, $1
} next }}
{ if (0 == system("test -f "src"/"$1)) { "dirname "$1 | getline path; close(cmd)
    "stat -c %a "src"/"$1 | getline mod; close(cmd)
    if (0 == system("test ! -d "dst"/"path)) {
        system("install -m 755 -d "dst"/"path)
        printf "install -m 755 -d %s/%s;\n", dst, path
    }
    system("install -m "mod" -t "dst"/"path" "src"/"$1)
    printf "install -m %s -t %s/%s %s/%s;\n", mod, dst, path, src, $1
next }}
{ printf "echo not found %s in %s!\n", $1, src}
END {}
