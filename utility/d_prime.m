function out = d_prime( V )
%Calculate d' for a set of data
%V: cell array of data {v1, v2, ..., vN}
    if nargin == 0
        g = @(m)randn(100,1)+m;
        V = arrayfun(@(m)g(m),0:0.5:2,'unif',0);
    end
    ndat = length(V);
    out = NaN(ndat);
    for rw = 1:ndat
        for cl = rw+1:ndat
            out(rw, cl) = d_prime_single(V{rw}, V{cl});
        end
    end

end

% function out = d_prime_single(v1, v2)
%     dm = mean(v2)-mean(v1);
%     sv = sqrt((var(v1) + var(v2))/2);
%     out = dm/sv;
% end

