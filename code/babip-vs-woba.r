require(glmnet)
require(lme4)
require(Matrix)
source('code/util.r')

data = read.csv('data/all2015.csv', header = FALSE)
colnames(data) = read.csv('data/fields.csv')$Header

batter = data$BAT_ID
pitcher = data$PIT_ID
pa = data$BAT_EVENT_FL
onbase = is.element(data$EVENT_CD, c(14:17, 20:23))
bip = is.element(data$EVENT_CD, c(2, 18:22))
hip = is.element(data$EVENT_CD, 20:22)
BIP = aggregate(bip, by = list(batter), sum)
minBatters = BIP$Group.1[BIP$x > 300]
qual = is.element(batter, minBatters)

first150 = function(x) {sum(x[1:150])}
second150 = function(x) {sum(x[151:300])}

OBP1 = aggregate(onbase[qual&pa], by = list(batter[qual&pa]), first150)$x/150
BABIP1 = aggregate(hip[qual&bip], by = list(batter[qual&bip]), first150)$x/150
OBP2 = aggregate(onbase[qual&pa], by = list(batter[qual&pa]), second150)$x/150
BABIP2 = aggregate(hip[qual&bip], by = list(batter[qual&bip]), second150)$x/150

sqrt(mean((OBP1 - OBP2)^2))
sqrt(mean((BABIP1 - BABIP2)^2))



x = sparseMatrix(1:sum(qual & month<7), as.numeric(as.factor(as.character(
    batter[qual & month<7]))))

priorMean = sum(OB1)/sum(PA1)
var = priorMean*(1-priorMean)/PA1
priorVar =
    estimatePopulationVariance(OB1/PA1, var, priorMean)
OBhat1 = ((OB1/PA1)/var + priorMean/priorVar)/(1/var + 1/priorVar)
OBhat2 = OB1/PA1
fit = cv.glmnet(x, onbase[qual & month<7], family = 'binomial', alpha = 0,
    standardize = FALSE, lambda = exp(seq(0, -10, length = 11)))
OBhat3 = predict(fit, diag(ncol(x)), s = 'lambda.min', type = 'response')
fit = glmer(onbase ~ (1|batter), family = binomial(link = 'probit'),
    subset = qual & month<7)
OBhat4 = predict(fit, data.frame(batter = sort(unique(batter[qual]))),
    type = 'response')

priorMean = sum(HIP1)/sum(BIP1)
var = priorMean*(1-priorMean)/BIP1
priorVar =
    estimatePopulationVariance(HIP1/BIP1, var, priorMean)
BABIPhat1 = ((HIP1/BIP1)/var + priorMean/priorVar)/(1/var + 1/priorVar)
BABIPhat2 = HIP1/BIP1
fit = cv.glmnet(x, onbase[qual & month<7], family = 'binomial', alpha = 0,
    standardize = FALSE, lambda = exp(seq(0, -10, length = 11)))
OBhat3 = predict(fit, diag(ncol(x)), s = 'lambda.min', type = 'response')
fit = glmer(onbase ~ (1|batter), family = binomial(link = 'probit'),
    subset = qual & month<7)
OBhat4 = predict(fit, data.frame(batter = sort(unique(batter[qual]))),
    type = 'response')

