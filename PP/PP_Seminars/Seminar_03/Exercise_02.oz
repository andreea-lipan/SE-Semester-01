% Exercise 2. (Taking and Dropping Elements)

% ----- Requirements ------
% Write two functions {Take Xs N} and 
% {Drop Xs N}. The call {Take Xs N} returns the first N 
% elements of Xs whereas the call {Drop Xs N} returns Xs 
% without its first N elements. For example, {Take [1 4 3 6 2] 3} 
% returns [1 4 3] and {Drop [1 4 3 6 2] 3} returns [6 2]. 


% ----- Solution -----
declare
fun {Take Xs N}
    if N == 0 then nil 
    else
        case Xs of nil then nil
        [] X | Xs then X | {Take Xs N-1} 
        end
    end
end

declare
fun {Drop Xs N}
    case Xs of nil then nil
    [] X | Xs then 
        if N == 1 then Xs else {Drop Xs N-1} 
        end
    end
end


% ----- Examples -----
declare 
L = [1 2 3 4 5 6]

{Browse {Take L 3}}
{Browse {Drop L 3}}