#' A function to print information about the current environment.
#'
#' This function prints current environment information, and a message.
#' @param msg The message that should be printed
#' @keywords debugging
#' @export
#' @examples
#' environment_info("Hi, what is your name?")
environment_info <- function(msg){
    print("This should really do something useful!")
    print(paste("Also print the incoming message: ", msg))
}