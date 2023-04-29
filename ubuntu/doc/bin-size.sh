#!/bin/bash
SCRIPT_SRCDIR=$(dirname -- ${BASH_SOURCE[0]:-$0})
BINNAME=${1:-ffmpeg}
LINKED_LIBS=$(lsof -p $(pidof "$BINNAME") -F n | grep -o '^n\(/.*\.so.*\)' | grep -o '[^n].*' && which "$BINNAME")

# Nicely list linked libs
(for f in $LINKED_LIBS; do
    printf "%s %s %s %s\n" \
        $(find "$f" -printf "%s") \
        $(numfmt --to=iec --suffix=B --format="%9.2f" $(find "$f" -printf "%s")) \
        "$(ls --color "$f")" \
        "$([[ "$(file "$f")" =~ 'not stripped' ]] || echo '(stripped!)')" \
        ;
done)    \
    |    \
(sort -h | uniq | awk -f "$SCRIPT_SRCDIR/bin-size.gawk")

# Prints total
printf $'\e[0;31m%10s\ttotal\n\e[m' \
    $(numfmt --to=iec --suffix=B --format="%9.2f" \
        $( (xargs du -cb | tail -n 1 | cut -f 1) <<< "$LINKED_LIBS" ) \
    )
