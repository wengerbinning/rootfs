BEGIN { if (!src || !dst) {
    printf "please set src & dst !\n";
    printf " Ex: awk -f install.awk -vsrc=src -vdst=dst pkg-list\n"
    exit
} else {
    if (src !~ /.*\/$/) src = src "/"
    if (dst !~ /.*\/$/) dst = dst "/"
    printf "# %s -> %s\n", src, dst
}}

#
{ if (NF == 0 || $1 ~ /^[ \t]*#.*/) next }
{ file=$1; sub(/[*#@!]$/, "", file);  }
# link file
{ if (NF == 3 && $2 == "->") {
	"dirname "$1 | getline path; close(cmd)
	if (0 == system("test ! -d "dst"/"path)) {
		# system("install -m 755 -d "dst"/"path)
		printf "install -m 755 -d %s%s\n", dst, path
	}
	# system("ln -sf "$3" "dst"/"$1)
	printf "ln -sf %s %s%s\n", $3, dst, $1
next }}

# folder file
{ if ($1 ~ /^.*\/$/) { if (0 == system("test ! -d "dst"/"$1)) {
	# system("install -m 755 -d "dst"/"$1)
	printf "install -m 755 -d %s%s\n", dst, $1
} next }}

# normal file
{ if (0 == system("test -f "src""file)) {
	"dirname "file | getline path; close(cmd)
	"stat -c %a "src"/"file | getline mod; close(cmd)
	if ($1 ~ /^.*\*$/) mod = 755
	if ($1 ~ /^.*#$/)  mod = 444
	if ($1 ~ /^.*@$/)  mod = 600
	if (0 == system("test ! -d "dst""path)) {
		system("install -m 755 -d "dst""path)
		printf "install -m 755 -d %s%s\n", dst, path
	}
	system("install -b -m "mod" -t "dst"/"path" "src""file)
	printf "install -b -m %s -t %s%s %s%s #\n", mod, dst, path, src, file
next }}

#
{ printf "warning:\033[33m not found %s in %s!\033[0m\n", file, src> "/dev/stderr"}
END {}
