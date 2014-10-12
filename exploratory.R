# Slight data cleaning
mymtcars <- mtcars
mymtcars$am[mymtcars$am==0] <- 'Automatic'
mymtcars$am[mymtcars$am==1] <- 'Manual'
mymtcars$am <- factor(mymtcars$am)

# Exploratory plot
library(ggplot2)
ggplot(mymtcars, aes(x = wt, y = mpg, color = am)) +
    geom_point() +
    labs(color = "Transmission", x = "Weight", y = "Fuel consumption (mpg)")

## Fit a few linear models
fit1 <- lm(mpg ~ am, mymtcars)
fit2 <- lm(mpg ~ am + wt, mymtcars)
fit3 <- lm(mpg ~ am + wt + hp, mymtcars)

## Is the latter fit better?
print(anova(fit1, fit2, fit3))
# Yes, fit3 seems to be significantly best.

# Including more variables does not help though -- all of these yield an
# anova p-value larger than 5%.
fit4 <- lm(mpg ~ am + wt + hp + factor(cyl), mtcars)
fit5 <- lm(mpg ~ factor(am) + wt + hp + disp, mtcars)
fit6 <- lm(mpg ~ factor(am) + wt + hp + drat, mtcars)
fit7 <- lm(mpg ~ factor(am) + wt + hp + qsec, mtcars)

print(anova(fit3, fit4))
print(anova(fit3, fit5))
print(anova(fit3, fit6))
print(anova(fit3, fit7))

# Thus, fit3 should be the model to look at. Residuals have a nice
# normal distribution.
plot(fit3, which = 1)
# TODO: MORE DIAGNOSTICS

# In fit1, the regression coefficient of am is strongly significant, while in
# fit3, it is not. In other words, weight and horsepower are correlated with am
# and explain most of the mpg difference. However, before and after including
# weight and horsepower into our model, it is the case that manual transmission
# is associated with higher mpg, though again not significantly if controlling
# for wt and hp.