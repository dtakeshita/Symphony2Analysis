function [X,Y,N] = get_probdist(V)
%Calculate discrite probability distribution
    X = min(V):1:(max(V)+1);
    N = histc(V,X)';
    Y = N/sum(N);
end