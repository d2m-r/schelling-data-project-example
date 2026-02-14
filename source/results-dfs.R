######## COIN FLIPS ######## 

coins <- raw_responses |> 
    select(coin_same, coin_different) |> 
    drop_na() |> 
    pivot_longer(
        cols = c(coin_same, coin_different), 
        names_to = "goal", 
        names_prefix = "coin_", 
        values_to = "side") |> 
    mutate(goal = fct_recode(goal, 'Choose same' = "same", 'Choose different' = "different") |> fct_rev())

######## NUMBERS ######## 

numbers <- raw_responses |> 
    select(number_0_10, number_list, number_big) |> 
    mutate(
        # Convert the first 2 to ordered factors
        number_0_10 = factor(number_0_10, ordered=T),
        number_list = factor(number_list),
        # Add a new factored version of the big number question
        # to retain the free response text
        number_big_fct = factor(number_big, ordered=T)) |> 
    na.omit()
