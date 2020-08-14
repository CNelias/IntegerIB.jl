using Test
using IntegerIB

#bach chorale data, taken from Nori Jacoby's webpage.
bach_histogram = [0.00001 392 14 582 896 262 106; 12 0.0001 15 5 674 17 182; 13 6 0.0001 44 12 32 3; 239 134 16 0.0001 380 13 173; 2099 25 46 93 0.00001 211 2; 96 206 25	95	172	0.00001 36; 499 1 4 9 24 20 0.00001]
pxy = bach_histogram./sum(bach_histogram)
model = IB(pxy, 0.95, "DIB")
brute_optimize!(model)
h, ixt, iyt, L = calc_metrics(model)
@test size(model.qt_x, 1) == 5
@test round(h, digits = 2) == 2.06
@test round(ixt, digits = 2) == 2.06
@test round(iyt, digits = 2) == 0.78
@test round(L, digits = 2) == 1.32
