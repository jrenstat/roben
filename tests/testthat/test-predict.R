test_that("check_prediction_robust", {
  set.seed(12345)
  test = sample((1:nrow(X)), floor(nrow(X)/4))
  fit=roben(X[-test,], Y[-test,], E[-test,], clin[-test,], iterations = 5000)
  out = predict(fit, X[test,], E[test,], clin[test,], Y[test,])
  expect_equal(names(out$error), "PMAD")
  expect_length(out$y.pred, length(test))
})

test_that("check_prediction_robust", {
  set.seed(12345)
  test = sample((1:nrow(X)), floor(nrow(X)/4))
  fit=roben(X[-test,], Y[-test,], E[-test,], clin[-test,], iterations = 5000)
  expect_error(predict(fit, X[test,-1], E[test,], clin[test,], Y[test,]), "X.new")
  expect_error(predict(fit, X[test,], E[test,], clin[test,-1], Y[test,]), "clinical covariates")
})


test_that("check_prediction_nonrobust", {
  set.seed(12345)
  test = sample((1:nrow(X)), floor(nrow(X)/4))
  fit=roben(X[-test,], Y[-test,], E[-test,], clin[-test,], iterations = 5000, robust=FALSE)
  out = predict(fit, X[test,], E[test,], clin[test,], Y[test,])
  expect_equal(names(out$error), "PMSE")
  expect_length(out$y.pred, length(test))
})

test_that("prediction reuses training centers for new data", {
  object = list(
    coefficient = list(
      Int = 5,
      clin = numeric(),
      E = c(E1 = 30),
      GE = matrix(c(10, 20), nrow = 2, dimnames = list(c("main", "E1"), "G1"))
    ),
    design = list(centers = list(X = 100, E = 50))
  )
  class(object) = c("roben", "Sparse", "RBVS")

  out = predict(object, X.new = matrix(110, nrow = 1), E.new = matrix(60, nrow = 1))

  expect_null(out$error)
  expect_equal(as.numeric(out$y.pred), 2405)
})

test_that("robust prediction print label matches PMAD", {
  object = list(
    coefficient = list(
      Int = 5,
      clin = numeric(),
      E = c(E1 = 30),
      GE = matrix(c(10, 20), nrow = 2, dimnames = list(c("main", "E1"), "G1"))
    ),
    design = list(centers = list(X = 100, E = 50))
  )
  class(object) = c("roben", "Sparse", "RBVS")

  out = predict(object, X.new = matrix(110, nrow = 1), E.new = matrix(60, nrow = 1), Y.new = 2400)

  expect_equal(names(out$error), "PMAD")
  expect_output(print(out), "PMAD")
})
