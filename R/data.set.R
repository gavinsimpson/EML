#' Create a data.set object (data.frame with metadata)
#' @param ... arguments as for data.frame
#' @param col.defs Character string vector with entries defining each column. Can be named by the row-names to which they correspond, otherwise are assumed to be in the order of the columns.  
#' @param unit.defs List providing definitions for the units used in each column.  See details. The list can be named  by the row-names to which they correspond, otherwise are assumed to be in the order of the columns.
#' @details The unit definition provided for the column will depend on the column class - please be sure columns are assigned the appropriate classes (e.g. dates appear as "Date", numerical values appear as "numeric" and not "character" or "factor", etc.  Then define units as follows: 
#'
#' * Numerical values should simply state the unit used in camelCase, as provided in the list of standard units.  
#' * Factors (including ordered factors) should provide a character vector of descriptions for each level, with names matching the factor keys.  
#' * Date or time objects should provide a format string, such as "YYYY", or "YYYY-MM-DD", to indicate the format used.  
#' * character strings should provide a general description of what the code or string is meant to describe (e.g. may be identical to column heading in this case).
#' 
#' WARNING: promoting to a `data.table` will work, but apply only to the data.frame part of the data structure.  The additional metadata attributes will be lost. 
#' @export
#' @include eml.R
data.set <- function(..., col.defs, unit.defs){

  # if named, re-order col.defs to match order given in `names` 
  # if named, re-order unit.defs to match order given in `names` 

  ds <- data.frame(...)
  new("data.set", data.frame(...), col.defs = col.defs, unit.defs = unit.defs)
}

### Actually can use the s4 method.  attributes are slots Dies require the formal calss be defined, even though we construct with `attr` and not `news` above... 
setClass("data.set",
         slots = c(col.defs = "character",
                        unit.defs = "list"),
         contains = "data.frame")



setGeneric("get_metadata", function(object) standardGeneric("get_metadata"))
# Construct the metadata list from unit.defs and col.defs  
setMethod("get_metadata", "data.set", function(object){
          out <- lapply(1:length( slot(object, "names")), 
                        function(i){
                 list(slot(object, "names")[i], 
                      slot(object, "col.defs")[i],
                      slot(object, "unit.defs")[[i]])
                        })
            names(out) <- slot(object, "names")
            out
            })

# data.frames have NULL metadata.  Avoids an error when calling this on a data.frame, 
# which allows EML to envoke the metadata wizard.  
setMethod("get_metadata", "data.frame", function(object) NULL)





