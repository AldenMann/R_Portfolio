
# Resource Finder:
RsrceFinder = function(DT, FilterBy = "Resource", FilterValue = "Base Metals", GroupBy = "Output"){
  data %>% 
    select_if(is.atomic) %>% 
    filter(str_detect(!! rlang::sym(FilterBy), FilterValue)) %>% 
    group_by(!!! rlang::syms(GroupBy)) %>% 
    drop_na() %>% 
    datatable()
}


#test1 = RsrceFinder(FilterBy = "Resource", FilterValue = "Base Metals", GroupBy = "Output")

# is.data.frame(test1)

# test1 %>% RsrceFinder()
 