function [ ranges, centroids ] = GenerateNaiveLevels( nLevels )

% generates uniformly distributed levels and centroids

ranges = double(zeros(1, nLevels));
centroids = double(zeros(1, nLevels));
for i=1:nLevels
    ranges(i) = uint8(1.0 / nLevels * i * 255);
    if i == 1, c = 0; else c = ranges(i-1); end;
    centroids(i) = uint8(c + (ranges(i) - c) / 2);
end

end

