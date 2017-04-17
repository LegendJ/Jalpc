---
layout: post
title:  "Tree models in machine learning"
date:   2017-04-17
desc: "Strengths and weaknesses of different tree models"
keywords: "ml,decision_tree, random_forest,ensemble learning"
categories: [Ml]
tags: [ml,decision_tree]
icon: icon-html
---
## Strengths and weaknesses of trees
* Non-parametric model,proved to be consistent
* Support heterogeneous(非均匀的)e.g.continuous,ordered or categorical variables).
* Flexibility in loss functions (choice is limited).
* Fast to train,fast to predict.
* In the average case,complexity of training is θ(pN log²N)
* Easily interpretable.
* Low bias but usually high variance.

## Diagnosing the error of RF
> Combine the predictions of several randmized trees into a single model.

* Bias: Identical to the bias of a single randomized tree.
* Variance: decrase var(x) (bagging focus on var,while boosting focus on bias)

## Strengths and weaknesses of forests
* One of the best off-the-self learning algorithm,requiring almost no tuning.
* Fine control of bias and variance through averaging and randomization,resulting in better performance.
* Moderately fast to train and to predict
* Embarrassingly parallel(using param n_jobs): a problem that is obviously decomposable into many identical but separate subtasks (embarrassingly parallel --高度并行？)
* Less interpretable than decision trees.

## Strengths and weaknesses of GBRT
* Often more accurate than random forests
* Flexible framework,that can adapt to arbitrary loss functions
* Fine control of under/overfitting through regularization(e.g. learning rate ,subsampling,tree structure,penalization term in the loss function,etc)
* Careful tuning required,Slow to train,fast to predict.

### To do GRBT Regularization：
* Tree structure:
  * Use max_depth control the degree of feature interactions 
  * Use min_samples_leaf to have a sufficient nr. of samples per leaf(避免将一个outlier也生成一个叶子节点)
* Shrinkage：
  * Slow learning by shrinking tree predictions with 0<learning_rage<=1
  * Lower learning_rate requires higher n_estimators
* SGD:
  * Samples: random subset of the training set(subsample)
  * Features: random subset of features(max_features)
  * both improved accuracy - reducted runtime

## Hyperparameter Tuning steps：
1. Set n_estimators as high as possible(eg. 3000)
2. Tune hyperparams via grid search.
```
param_grid  = {'learning_rate ':[0.1,0.05,0.02,0.01]
     'max_depth':[4,6]
     'max_sample_leaf':[3,5,9,17],
     'max_features':[1,0.3,0.1]}
     est = GradientBtR(n_estimators=3000)
     gs_cv = GridSearchCV(est,param_grid).fit(X,y)
     gs_cv.best_params_
```

## Visualization:
* Variable importances
```
     importances = pd.DataFrame()
     importances["RF"] = pd.Series(est.feature_importances_,
     index=feature_names)
     importances.plot(kind="barh")
```
* Partial dependence plots
```
from sklearn.ensemble.partial_dependence import plot_partial_dependence
     plot_partial_dependence(gbrt,X,
     features=[1,10],feature_names=feature_names)
```

## Note:
sklearn中随机森林和提升树的树不同，随机森林的树，通常比较深，而且具有较多的随机性（we usually grow very deep trees lots of  randomization and in boosting we rather draw very shallow trees and hardly any randomization and this is quite a lot of  implications）
