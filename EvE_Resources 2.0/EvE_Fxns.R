
# Resource Finder:
RsrceFinder = function(data, DT, FilterBy = "Resource", FilterValue = "Base Metals", GroupBy = "System"){
  data %>% 
    select_if(is.atomic) %>% 
    filter(str_detect(!! rlang::sym(FilterBy), FilterValue)) %>% 
    group_by(!!! rlang::syms(GroupBy)) %>% 
    drop_na() %>% 
    as.data.frame()
}


# test1 = RsrceFinder(FilterBy = "Resource", FilterValue = "Base Metals", GroupBy = "Output")
# 
# is.data.frame(test1)

# test1 %>% RsrceFinder()
 