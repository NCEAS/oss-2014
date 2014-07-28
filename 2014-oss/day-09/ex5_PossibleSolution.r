
text_file = read.table( "test_data.txt" )

INVALID_ENTRY <- -10000
SUCCESS       <- 0
check_for_errors <- function( entry1, entry2, entry3 ) {
    if( entry1 <= 0 || entry2 <= 0 || entry3 <=0 ) {
        return( INVALID_ENTRY )
    } else {
        return( SUCCESS )
    }
}

process_frog <- function( entry1, entry2, entry3 ) {
    if( SUCCESS == check_for_errors( entry1, entry2, entry3 ) ) {
        # science happens here
        frog_results <- entry1 + entry2 + entry3
        print( sprintf( "frog results %f", frog_results ) )
    } else {
        print( "invalid frog" )

    }
}

process_turtle <- function( entry1, entry2, entry3 ) {
    if( SUCCESS == check_for_errors( entry1, entry2, entry3 ) ) {
        # different science happens here
        turtle_results <- entry1 * entry2 * entry3
        print( sprintf( "turtle results %f", turtle_results ) )
    } else {
        print( "invalid turtle" )

    }
}

process_snake <- function( entry1, entry2, entry3 ) {
    if( SUCCESS == check_for_errors( entry1, entry2, entry3 ) ) {
        # even more science happens here
        snake_results <- entry1 + entry2 / entry3
        print( sprintf( "snake results %f", snake_results ) )
    } else {
        print( "invalid snake" )

    }
}

process_lizard <- function( entry1, entry2, entry3 ) {
    if( SUCCESS == check_for_errors( entry1, entry2, entry3 ) ) {
        # better science happens here
        lizard_results <- entry1 / entry2 * entry3
        print( sprintf( "lizard results %f", lizard_results ) )
    } else {
        print( "invalid lizard" )

    }
}

frog_counter <- 0
for( row_idx in 1:nrow( text_file ) ) {
    entry0 <- text_file[row_idx, 1]
    entry1 <- text_file[row_idx, 2]
    entry2 <- text_file[row_idx, 3]
    entry3 <- text_file[row_idx, 4]

    if( entry0 == "frog" ) {
        process_frog( entry1, entry2, entry3 )
        frog_counter <- frog_counter + 1

    } else if ( entry0 == "turtle" ) { 
        process_turtle( entry1, entry2, entry3 )

    } else if ( entry0 == "snake" ) { 
        process_snake( entry1, entry2, entry3 )

    } else if ( entry0 == "lizard" ) { 
        process_lizard( entry1, entry2, entry3 )

    } else {
        print( sprintf( "invalid entry for [%s]", entry0 ) )

    }
}

print( sprintf( "frog_count %d", frog_counter ) )
