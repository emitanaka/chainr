test_that("select", {

  usa <- chain(
    state_stats = as.data.frame(state.x77),
    state_info = data.frame(name = state.name,
                            abb = state.abb,
                            division = state.division,
                            region = state.region),
    arrests = USArrests
  )

  expect_equal(select(usa, state_stats, Population:Illiteracy),
               {
                 out <- usa
                 out[["state_stats"]] <- out[["state_stats"]][, c("Population", "Income", "Illiteracy")]
                 out
               })

  expect_equal(select_links(usa, state_stats), usa["state_stats"])
})
