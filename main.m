clear all;
close all;
%%

filename = 'C:\Users\Eliott\Google Drive\Hackathon\Datasets\toy_data.csv';
M = csvread(filename,1,0);
filename = 'C:\Users\Eliott\Google Drive\Hackathon\range.csv';
range = csvread(filename,1,0);
M = M(:,2:end);
tableSize = size(M,1);
allIds = sort(unique(M(:,1)));
nNodes = length(allIds);
times = zeros(nNodes);
for i=1:tableSize
    initialId = M(i,1);
    newId = find(allIds==initialId);
    M(i,1) = newId;
end
for i=1:tableSize
    initialId = M(i,3);
    newId = find(allIds==initialId);
    M(i,3) = newId;
end

for i=1:tableSize
    node1 = M(i,1);
    node2 = M(i,3);
    dist = M(i,2);
    if dist<range,
        times(node1,node2) = M(i,4); 
    else
        times(node1,node2) = inf; 
    end;
    if dist<range, 
        times(node2,node1) = M(i,4);
    else
        times(node2,node1) = inf; 
    end
end

% Dijkstra

n = nNodes; A = zeros(n); xy = 10*rand(n,2)
tri = delaunay(xy(:,1),xy(:,2));
I = tri(:); J = tri(:,[2 3 1]); J = J(:);
IJ = I + n*(J-1); A(IJ) = 1
[cost,path] = dijkstra(A,xy,1,2);

