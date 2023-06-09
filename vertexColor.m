function [f] = vertexColor(G)


% check if vertices have names
if (~sum(ismember(G.Nodes.Properties.VariableNames,'Name')))
    % if not, give names using its indices
    Vnames = int2str(1:numnodes(G));
    G.Nodes.Name = split(Vnames);
end

% check if edges have names
if (~sum(ismember(G.Edges.Properties.VariableNames,'Name')))
    % if not, give names using its indices
    Enames = int2str(1:numedges(G));
    G.Edges.Name = split(Enames);
end

% set color of all Nodes as Inf, means uncolored
f(1:numnodes(G)) = -Inf;

%find position of the first node with max degree
[maxdegree, pos] = max(degree(G, G.Nodes.Name));

%set color of that node as 1
f(pos) = 1;

% set the while loops ~isempty(intersect(f, -inf)) means that if -inf is
% still inside f.
while ~isempty(intersect(f, -inf))


    pos=[];

    % loops through all the nodes, find any nodes that are not colored yet
    for i = 1:numnodes(G)
        if f(i) == -inf
            pos(end+1) = [i];
            
        end
    end

        %among those uncolored nodes, find the node with max degree
        [m,p] = max(degree(G, pos));
        
        %set that node as v_id
        v_id = pos(p);

        %find neighbors of node v_id
        ns = neighbors(G, v_id);

        % set the ccounting color from 1
        color = 1;

        % this while check if color at node v_id is colored or not
        % (isinf(f(v_id)) and then check if that color is in the neighbor
        % nodes of v_id or not (~isempty(intersect(f(ns), f(v_id)))))
        while (isinf(f(v_id)) || ~isempty(intersect(f(ns), f(v_id))))
           
            % start from color 1, if color is in used for neighbor of node 
            % v_id then add 1 more to color and assign to that node, repeat
            % the process, check the color is used or not, untill satisfy
            % all the conditions
            % 
            if ~isempty(intersect(f(ns), color))
                color = color +1;
                f(v_id) = color;
            elseif isempty(intersect(f(ns), color))
                f(v_id) = color;
            end
        end
end

f = f';

end % end functioin vertexColor
