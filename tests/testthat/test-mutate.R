test_that("murate", {
  usa <- chain(
    state_stats = as.data.frame(state.x77),
    state_info = data.frame(name = state.name,
                            abb = state.abb,
                            division = state.division,
                            region = state.region),
    arrests = USArrests
  )

  expect_equal(mutate(usa, arrests, y = 1),
               {
                 out <- usa
                 out$arrests$y <- 1
                 out
               })
})
