function newdata = mov_avg(data, n)
% takes a moving average of an array every n elements
% writes those n elements one value

    newdata = [];
    i = 1;

    while i < length(data)
        if i+n > length(data)
            moving = mean(data(i:end));
            lastns = length(data)-i+1;
            clones = ones(1, lastns) * moving;
        else
            moving = mean(data(i:(i+n)));
            clones = ones(1, n)*moving;
        end

        newdata = [newdata clones];
        i = i+n;

    end

end
