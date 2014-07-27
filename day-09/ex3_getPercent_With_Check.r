


getPercent <- function( value, pct ) {
    if( pct <= 0 ) {
        print( "getPercent - param 2 <= 0" )
        return( 0 )
    }

    result <- value * pct
    return( result )
}

result <- getPercent( 10, 1.1 )
print( result )

