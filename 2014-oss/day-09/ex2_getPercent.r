


getPercent <- function( value, pct ) {
    result <- value * ( pct / 100 )
    return( result )
}

result <- getPercent( 10, 110 )
print( result )

