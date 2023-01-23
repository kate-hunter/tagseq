{
    for ( rowNr=1; rowNr<=NF; rowNr++ ) {
        vals[rowNr,NR] = $rowNr
    }
}
END {
    for ( rowNr=1; rowNr<=NF; rowNr++ ) {
        for ( colNr=1; colNr<=NR; colNr++ ) {
            printf "%s%s", vals[rowNr,colNr], (colNr<NR ? OFS : ORS)
        }
    }
}