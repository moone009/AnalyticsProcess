

model = lm(mpg ~ wt + qsec + am,data=mtcars)

save(model, file = "mymodel.rda")

rm(model)

load("mymodel.rda")

predict(model,mtcars)