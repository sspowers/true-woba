# True wOBA: Estimation of true talent level for batters

Nominally, this is a paper introducing True wOBA, a wOBA estimator which
simultaneously accounts for sample size, park effects and quality of opposition
to facilitate comparisons between batters and between pitchers on a level
playing field. But there is little thirst in the sabermetric literature for
new batting metrics. The real contribution of this paper comes in
three parts.

First, we argue against the use of stabilization rates when interpreting small
sample sizes. For one matter, stabilization rates have more to do with the
population variance in true skill level than variance in the observed
statistic. For another, there is a spectrum of sample sizes, not just _too
small_ and _big enough_, a nuance not addressed by stabilization rates. We
advocate the use of regression to the mean to precisely quantify the
uncertainty due to finite sample sizes. A feature of regression to the mean for
wOBA is that it automatically learns that the population variance for
underlying BABIP skill is relatively small, thus regressing BABIP more
aggressively toward the mean. So regressed wOBA quantifies the assertion that
we expect players with high BABIP to see their performance drop off more than
players with low BABIP.

Second, we discuss in detail the relationship between regression to the mean
and its extension to shrinkage regression estimators pioneered by
\citet{Judge15}. In particular, we relate the penalty parameter in regularized
regression to the population variance parameter in regression to the mean to
explore conceptually the fundamental difference between how much shrinkage is
applied in each estimator.

Third, we make a novel comparison between regularized linear regression and
random effects linear models. This comparison leads to a discussion of the
relative strengths and weakness of the two approaches.

The goal of this paper is to review the fundamental statistical concepts that
relate to evaluating players on a level playing field, accounting for sample
size and other factors. No statistic readily available from FanGraphs.com or
Baseball-Reference.com accomplishes this task, which should be the first step
in player evaluation, as opposed to squinting at sample sizes and BABIPs to
ascertain whether a player's performance level is _sustainable_.

