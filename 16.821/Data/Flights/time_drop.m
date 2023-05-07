function newtime = time_drop(data, n, long)
% takes every nth element, drops any past certain length

    newtime = data(1:n:end);
    newtime = newtime(1:long);

end
