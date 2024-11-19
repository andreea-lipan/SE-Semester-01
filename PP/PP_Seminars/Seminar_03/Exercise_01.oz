% Exercise 1. (Finding an Element in a List)

% ----- Requirements ------
% Give a definition of {Member Xs Y} that tests whether Y 
% is an element of Xs. For this assignment you have to use 
% the truth values true and false. The equality test (that is ==)
% returns truth values and a function returning truth values 
% can be used as condition in an if-expression. For example, 
% the call {Member [a b c] b} should return true, whereas 
% {Member [a b c] d} should return false.


% ----- Solution ------
declare
fun {Member Xs Y}
    case Xs of nil then false
    [] X | Xs then
        if X == Y then true else {Member Xs Y}
        end
    end
end


% ----- Examples -----
declare
L = [a b c]

declare
fun {Test L Y}
    if {Member L Y} then 'found' else 'not found'
    end
end

{Browse {Test L d}}