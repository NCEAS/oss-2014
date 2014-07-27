
# error codes
INVALID_PARAMETER <- -1000000

getPercent <- function( value, pct ) {
    result <- INVALID_PARAMETER
    if( pct <= 0 ) {
        #print( "getPercent - param 2 <= 0" )
        return( result )
    }

    result <- value * ( pct / 100 )
    
    return( result )
}

# this should print out 11
result <- getPercent( 10, 110 )
if( result == INVALID_PARAMETER ) {
    cat( sprintf( "getPercent Failed - %d\n", result ) )
} else {
    print( result )
}

# this should result in an error message
result <- getPercent( 10, -2 )
if( result == INVALID_PARAMETER ) {
    cat( sprintf( "getPercent Failed - %d\n", result ) )
} else {
    print( result )
}

