compose_data_package <- function(list_of_packages) {
    pkg <- create_package()
    
    list_of_packages %>%
        walk(
            .f = function(x) {
                dat <- data_and_labels(pluck(x$dhs_data, 1))$data %>%
                    zap_labels()
                
                labs <- data_and_labels(pluck(x$dhs_data, 1))$variable_names
                schema <- create_schema(dat)
                desc_lookup <- setNames(labs$description, labs$variable)

                schema$fields <- map(schema$fields, \(field) {
                    field$description <- unname(desc_lookup[field$name])
                    field
                })

                pkg <<- pkg %>%
                    add_resource(
                        data = dat,
                        resource_name = unique(x$description),
                        schema = schema
                    )
            }
        )

return(pkg)
}