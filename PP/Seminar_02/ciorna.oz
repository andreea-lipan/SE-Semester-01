% declare
%     BTree = nil

% fun {Insert Root Node}
%     case Root of nil then node(Node nil nil)
%     [] node(Value Left Right) then 
%         if Node < Value then
%             node(Value {Insert Left Node} Right)
%         else
%             node(Value Left {Insert Right Node})
%         end
%     end
% end

% declare bs = {Insert BTree 3}
% {Browse bs}