NF>=4{printf "%10s\t%s\t%s\n", $2, $4, $3} NF<4{printf "%10s\t\t\t%s\n", $2, $3}
