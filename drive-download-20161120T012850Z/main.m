clear all;
close all;
%%

% filename = 'C:\Users\Eliott\Google Drive\Hackathon\Datasets\toy_data.csv';

filename = 'C:\Users\Eliott\Google Drive\Hackathon\Datasets\M.mat';
load(filename);

filename = 'C:\Users\Eliott\Google Drive\Hackathon\range.csv';
range = csvread(filename,1,0);
M = M(:,2:end);
tableSize = size(M,1);
allIds = sort(unique(M(:,1)));
nNodes = length(allIds);
times = zeros(nNodes);
A = zeros(nNodes);
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
    if dist<range
        A(node1,node2) =1; 
        A(node2,node1) =1;
    end
    times(node1,node2) = M(i,4);
    times(node2,node1) = M(i,4);
end

% Dijkstra

n = nNodes; A = zeros(n); xy = 10*rand(n,2)
tri = delaunay(xy(:,1),xy(:,2));
I = tri(:); J = tri(:,[2 3 1]); J = J(:);
IJ = I + n*(J-1); A(IJ) = 1
[cost,path] = dijkstra(A,times,1,2);

myPath = allIds(path)';

filename = 'C:\Users\Eliott\Google Drive\Hackathon\Datasets\path.csv';
csvwrite(filename,myPath);
filename = 'C:\Users\Eliott\Google Drive\Hackathon\Datasets\time.csv';
csvwrite(filename,cost);