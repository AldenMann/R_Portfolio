# removes commas from values that should be numerical and converts the values to numerical afer removal of the commas
Convert_comma_to_Numeric = function(data, column_name) {
  data[[column_name]] = as.numeric(gsub(",", "", data[[column_name]]))
  return(data)
}

# removes both dollar signs and commas then converts to numerical
remove_commas_dollars_and_convert_to_numeric = function(data, column_name) {
  data[[column_name]] = as.numeric(gsub("[\\$,]", "", data[[column_name]]))
  return(data)
}



