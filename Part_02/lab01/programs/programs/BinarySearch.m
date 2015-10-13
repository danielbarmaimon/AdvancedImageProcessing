function [Index]=BinarySearch(OrderedSet, v, n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Perform a binary search on an array.
%   Return the index of the element
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Bottom = 1;
Top = n;

while Top>Bottom+1
    Center = int16((Bottom+Top)/2);
    if v < OrderedSet(Center)
        Top = double(Center);
    else
        Bottom = double(Center);
    end
end
Index = Bottom;