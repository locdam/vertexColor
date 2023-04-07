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
f(1:numnodes(G)) = -Inf;
%find postiotion of the first node with max degree
[maxdegree, pos] = max(degree(G, G.Nodes.Name));

f(pos) = 1;

while ~isempty(intersect(f, -inf))
    pos=[];
    for i = 1:numnodes(G)
        if f(i) == -inf
            pos(end+1) = [i];
            
        end
    end
        [m,p] = max(degree(G, pos));
        v_id = pos(p);
        ns = neighbors(G, v_id);
        color = 1;
        while (isinf(f(v_id)) || ~isempty(intersect(f(ns), f(v_id))))
           
            
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
