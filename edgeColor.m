function [f] = edgeColor(G)

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

% set color of all Edges as Inf, means uncolored
f(1:numedges(G)) = -Inf;

% start from first edge, color 1
f(1) = 1;

% set the while loops ~isempty(intersect(f, -inf)) means that if -inf is
% still inside f.
while ~isempty(intersect(f, -inf))

    %loop through all edges
    for i =1:numedges(G)

        %call edge ith as eidx
        eidx = i;

        %find endpoints of that edge
        endpts = G.Edges.EndNodes(eidx,:);
        endpts = findnode(G,{endpts{1} endpts{2}});

        % find outedges from endpoint 1
        ns_1 = outedges(G, endpts(1));

        % find outedges from endpoint 2
        ns_2 = outedges(G, endpts(2));

        % combine to get all the neighbor edges of edge ith
        ns = cat(1, ns_1, ns_2);
        ns = unique(ns);
        ns = setdiff(ns, eidx);

        % set the ccounting color from 1
        color = 1;

        % this while check if color at edge eidx is colored or not
        % (isinf(f(eidx)) and then check if that color is in the neighbor
        % edges of eidx or not (~isempty(intersect(f(ns), f(eidx)))))
        while (isinf(f(eidx)) || ~isempty(intersect(f(ns), f(eidx))))
           
            % start from color 1, if color is in used for neighbor of edge 
            % eidx then add 1 more to color and assign to that edge, repeat
            % the process, check the color is used or not, untill satisfy
            % all the conditions
            % 
            if ~isempty(intersect(f(ns), color))
                color = color +1;
                f(eidx) = color;
            elseif isempty(intersect(f(ns), color))
                f(eidx) = color;
            end
        end
    end
end

f = f'

end





