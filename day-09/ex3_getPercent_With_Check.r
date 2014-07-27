


getPercent <- function( value, pct ) {
    if( pct <= 0 ) {
        print( "getPercent - param 2 <= 0" )
        return( 0 )
    }

    result <- value * ( pct / 100 )
    return( result )
}

result <- getPercent( 10, 110 )
print( result )

