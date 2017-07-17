## The problem with C and the introduction of nu

The problem with the parameter C is:

1. that it can take any positive value
2. that it has no direct interpretation.

It is therefore hard to choose correctly and one has to resort to cross validation or direct experimentation to find a suitable value.

In response Schölkopf et al. reformulated SVM to take a new regularization parameter nu. This parameter is:

1. bounded between 0 and 1
2. has a direct interpretation

## Interpretation of nu

The parameter nu is an upper bound on the fraction of margin errors and a lower bound of the fraction of support vectors relative to the total number of training examples. For example, if you set it to 0.05 you are guaranteed to find at most 5% of your training examples being misclassified (at the cost of a small margin, though) and at least 5% of your training examples being support vectors.

## Relationship between C and nu

The relation between C and nu is governed by the following formula:

`nu = A+B/C`

A and B are constants which are unfortunately not that easy to calculate.

## Conclusion

The takeaway message is that C and nu SVM are equivalent regarding their classification power. The regularization in terms of nu is easier to interpret compared to C, but the nu SVM is usually harder to optimize and runtime doesn't scale as well as the C variant with number of input samples.