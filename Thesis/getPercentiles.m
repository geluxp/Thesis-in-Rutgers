function res = getPercentiles(plev, pvals, w)
dat = nan(1,sum(w));
ctr = 1;
for i=1:length(w)
    for j=1:w(i)
        dat(ctr) = interp1(plev, pvals(i,:), rand);
        ctr = ctr +1;
    end
end
res = dat;
