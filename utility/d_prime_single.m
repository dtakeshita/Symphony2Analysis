function out = d_prime_single(v1, v2)
    dm = mean(v2)-mean(v1);
    sv = sqrt((var(v1) + var(v2))/2);
    out = dm/sv;
end