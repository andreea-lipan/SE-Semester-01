% Exercise 4.  (Finding the Position of an Element in a List)

% ----- Requirements ------
% Write  a  function {Position Xs Y} that returns the first 
% position of Y in the list Xs. The positions in a list 
% start with 1. For example, {Position [a b c] c} returns 3 
% and {Position [a b c b] b} returns 2. 
% Try two versions: 
%    1) one that assumes that Y is an element of Xs and 
%    2) one that returns 0, if Y does not occur in Xs.


% ----- Solution with 0------
declare
fun {PositionWrap L X Poz} 
    case L of nil then 0
    [] Y | Ls then
        if X == Y then Poz else {PositionWrap Ls X (Poz+1)} end
    end
end

declare
fun {Position L X} 
    {PositionWrap L X 1}
end

declare
L = [a b c]
{Browse {Position L b}}


% ----- Solution assuming val exists -----
declare
fun {PositionWrap2 L X Poz}
    case L of Y | Ls then
        if X == Y then Poz else {PositionWrap2 Ls X (Poz+1)} end
    end
end

declare
fun {Position2 L X} 
    {PositionWrap2 L X 1}
end

declare
L = [a b c]
{Browse {Position2 L a}}


% ----- Solution assuming val exists -----
declare
fun {Position3 L X} 
    case L of Y | Ls then
        if X == Y then 1 else 1 + {Position3 Ls X} end
    end
end


declare
L = [a b c]
{Browse {Position3 L c}}