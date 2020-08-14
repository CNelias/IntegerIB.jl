# IntegerIB.jl

A julia module to apply the **information bottleneck** for clustering when dealing with **categorical data**. 

| **Travis**     |
|:---------------:|
|[![Build Status](https://travis-ci.com/johncwok/IntegerIB.jl.svg?branch=master)](https://travis-ci.com/johncwok/IntegerIB.jl)|

The information bottleneck concept can be used in the context of categorical data analysis to do **clustering**, 
or in other words, to look for categories which have equivalent functions. <br/>
Given a time-series, it looks for a **concise representation** of the data that preserves as much **meaningfull information** as possible. 
In a sense, it is a lossy compression algorithm. The information to preserve can be seen as the ability to make predictions : 
given a specific **context**, how much of what is coming next can we predict ? <br/>
The goal of this algorithm is to cluster categorical data while preserving prediction power. To learn more about the informationbottleneck 
you can look at *https://arxiv.org/abs/1604.00268* or *https://doi.org/10.1080/09298215.2015.1036888*


The amount of **compression** as well as definition of **relevant context** can be user-choosen.



### Installation and import :

## Usage :

## Acknowledgments :
Special thanks to Nori jacoby from whom I learned a lot on the subject. The IB part of this code was tested with his data and reproduces his results. <br/>
The present implementation is adapted from DJ Strouse's paper https://arxiv.org/abs/1604.00268 and his python implementation.

## To-do
Finish writing readme, add tests
