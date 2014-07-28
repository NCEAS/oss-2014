text_file = read.table( "test_data.txt" )

frog_flag <- 0
frog_counter <- 0
for( row_idx in 1:nrow( text_file ) ) {
    entry0 <- text_file[row_idx, 1]
        
    if( entry0 == "frog" ) {
        frog_flag <- 1

        entry1 <- text_file[row_idx, 2]
        entry2 <- text_file[row_idx, 3]
        entry3 <- text_file[row_idx, 4]
        if( entry1 <= 0 || entry2 <= 0 || entry3 <=0 ) {
            print( "invalid frog" )
        } else {
            # science happens here - some of entries produces the frog index
            frog_results <- entry1 + entry2 + entry3
            print( sprintf( "frog results %f", frog_results ) )
        }

    } else if ( entry0 == "turtle" ) { 
        entry1 <- text_file[row_idx, 2]
        entry2 <- text_file[row_idx, 3]
        entry3 <- text_file[row_idx, 4]
        if( entry1 <= 0 || entry2 <= 0 || entry3 <=0 ) {
            print( "invalid turtle" )
        } else {
            # science happens here - some of entries produces the frog index
            turtle_results <- entry1 * entry2 * entry3
            print( sprintf( "turtle results %f", turtle_results ) )
        }

    } else if ( entry0 == "snake" ) { 
        entry1 <- text_file[row_idx, 2]
        entry2 <- text_file[row_idx, 3]
        entry3 <- text_file[row_idx, 4]
        if( entry1 <= 0 || entry2 <= 0 || entry3 <=0 ) {
            print( "invalid snake" )
        } else {
            snake_results <- entry1 + entry2 / entry3
            print( sprintf( "snake results %f", snake_results ) )
        }

    } else {
        entry1 <- text_file[row_idx, 2]
        entry2 <- text_file[row_idx, 3]
        entry3 <- text_file[row_idx, 4]
        if( entry1 <= 0 || entry2 <= 0 || entry3 <=0 ) {
            print( "invalid lizard" )
        } else {
            # process lizard  
            lizard_results <- entry1 / entry2 * entry3
            print( sprintf( "lizard results %f", lizard_results ) )
        }

    } 

    if( 1 == frog_flag ) {
        frog_counter <- frog_counter + 1
        frog_flag <- 0
    }

} # for i

print( sprintf( "frog_count %d", frog_counter ) )
