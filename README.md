# IntegerIB.jl

A julia module to apply the **information bottleneck** for clustering when dealing with **categorical data**. 

| **Travis**     |
|:---------------:|
|[![Build Status](https://travis-ci.com/johncwok/IntegerIB.jl.svg?branch=master)](https://travis-ci.com/johncwok/IntegerIB.jl)|

The information bottleneck concept can be used in the context of categorical data analysis to do **clustering**, 
or in other words, to look for categories which have equivalent functions. <br/>
Given a time-series, it looks for a **concise representation** of the data that preserves as much **meaningful information** as possible. 
In a sense, it is a lossy compression algorithm. The information to preserve can be seen as the ability to make predictions : 
given a specific **context**, how much of what is coming next can we predict ? <br/>
The goal of this algorithm is to cluster categorical data while preserving prediction power. To learn more about the information bottleneck 
you can look at *https://arxiv.org/abs/1604.00268* or *https://doi.org/10.1080/09298215.2015.1036888*

#### Installation & import:
```Julia
Using Pkg
Pkg.clone(“https://github.com/johncwok/IntegerIB.jl.git”)
Using IntegerIB
```
## Quick overview
To do a simple IB clustering of categorical data do as follow. First, map your categorical time-series to an array of integer 'x'. For example, if your data is ["a", "b", "c", "a", "c"], you can map it to [1, 2, 3, 1, 3]. Then instantiate a model and optimize it :
```Julia
model = IB(x) #you can call IB(x, beta). beta is a real number that controls the amount of compression.
IB_optimize!(model) 
```
Then, to see the results :
```Julia
print_results(model)
```
Rows are clusters and columns correspond to the input categories. The result is the probability `p(t|x)` of a category belonging to a given cluster. Since most of the probabilities are very low, ```print_results``` **sets every `p(t|x)` > 0.1 to 1, 0 otherwise** for ease of readability (see further usage for more options).
#### example:
Here is a concrete example with the bach chorales dataset. The input categories are the 7 chord function from classical harmony.
```Julia
bach = CSV.read("..\\data\\bach_histogram")
pxy = Matrix(bach)./sum(Matrix(bach))
model = IB(pxy, 1000) #You can also instantiate 'model' with a probability distribution instead of a time-series.
IB_optimize!(model)
print_results(model)
```
The output is in perfect accordance with music theory. It tells us that we can group category 1, 3 and 6 together : this corresponds to the ```tonic``` function in classical harmony. Category 2 and 4 have been clustered together, this is what harmony calls ```subdominant```. Finall category 5 and 7 are joined : this is the ```dominant``` function.

<img src=https://user-images.githubusercontent.com/34754896/90241511-7c625300-de2b-11ea-800d-3cee1da9fdf5.PNG width = "400">

## Further usage
#### Types of algorithm:
You can choose between the original IB algorithm (Tishby, 1999) which does *soft* clustering or the *deterministic* IB algorithm (DJ Strouse, 2016) doing *hard* clustering. The former seems to produce more meaningfull clustering. When instantiating a model ```IB(x::Array{Float64,1}, β = 200, algorithm = "IB")```, change the argument `algorithm` to "DIB" to use the deterministic IB algorithm.

#### Changing default parameters:
The two most important parameters for this kind of IB clustering are the amount **compression** and the definition of **relevant context**.<br/>

- The amount of compression is governed by the parameter `β` which you provide when instantiating an IB model ```IB(x::Array{Float64,1}, β = 200, algorithm = "IB")```. The smaller `β` is, the more compression. The higher `β`, the bigger the mutual information I(X;T) between cluster and original category is. <br/>
There are two undesirable situations : 
  - if `β` is too small, maximal compression is achieved and all information is lost. 
  - if `β` is too high, there is effectively no compression. With "DIB" algorithm, this can even happen even for `β` > ~5. **In the case of the "IB" algorithm this doesn't happen**, however for `β` values > ~1000, the algorithm doesnt optimize anything because all metrics are effectively 0. In practice, when using the "IB" algorithm, a high `β` value (~200) is a good starting point.<br/>

- The definition of **context** is essential to define what the meaningfull information to preserve is. 



## Acknowledgments
Special thanks to Nori jacoby from whom I learned a lot on the subject. The IB part of this code was tested with his data and reproduces his results. <br/>
The present implementation is adapted from DJ Strouse's paper https://arxiv.org/abs/1604.00268 and his python implementation.

## To-do
Finish writing 'further usage' section.
