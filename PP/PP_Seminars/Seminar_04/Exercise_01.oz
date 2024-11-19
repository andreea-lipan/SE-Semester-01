% Exercise 1. (Free variables)

% ----- Requirements ------
% Each variable that is captured in either lam or let construct 
% is said to be a "bound" identifier, while those that are not 
% captured are known as "free" variables. For example, given 
% 1am (x apply (y x) ), the variable y is free while variable x 
% is bound. Similarly. in the term apply (x let (x#y x)), the 
% first occurrence of x and y are said to be free, while the last
% occurrence of x is bound. Write a function, called FreeSet 
% which would return all free variables in an expression. 
% Some examples are:
% (FreeSet apply(x let (x#y x)) }   % returns [x y]
% {FreeSet apply(y apply(let (x#x x) y))} % returns [y] or [y y]


% ----- Solution ------
declare
fun {FreeSet Expr BoundVars}
    case Expr of apply(E1 E2) then
        {Union {FreeSet E1 BoundVars} {FreeSet E2 BoundVars}}
    [] lam(X E) then 
        {FreeSet E {Adjoin X BoundVars}}
    [] let(X#E1 E2) then
        {Union {FreeSet E1 BoundVars} {FreeSet E2 {Adjoin X BoundVars}}}
    [] X then
        if {IsMember X BoundVars} then
            nil
        else
            X
        end
    end
end

% Checks if X is member of List 
declare
fun {IsMember X List}
    case List of nil then false
    []  H | T then 
        if (X == H) then true else {IsMember X T} end
    end
end

% Concatenates 2 lists
declare
fun {UnionWrap L1 L2}
    case L1 of nil then L2
    [] H | L1 then
        if {IsMember H L2} then {UnionWrap L1 L2}
        else H | {UnionWrap L1 L2}
        end
    end
end

% Makes 2 elements into lists and concatenates
declare
fun {Union E1 E2}
    local L1 L2 in
                                        % First make sure both members are lists
        case E1 of nil then L1 = E1
        [] H | T then L1 = E1          % if list remains unchanged
        [] X then L1 = X | nil         % if element, creates list of 1 el
        end
        
        case E2 of nil then L2 = E2
        [] H | T then L2 = E2
        [] X then L2 = X | nil
        end

        {UnionWrap L1 L2}              % Concatenate the lists
    end
end

declare 
fun {Adjoin X L1}
    if {IsMember X L1} then L1 else X | L1 end
end


% ----- Examples -----
declare
L1 = [1 2]
declare
L2 =  [3 4]
{Browse {Adjoin 4 L1}}
{Browse {Union L1 L2}}
{Browse 5}


declare
Expr1 = apply(x let(x#y x))
FreeVars1 = {FreeSet Expr1 nil}
{Browse FreeVars1} % Expected output: {x y}

declare
Expr2 = lam(x apply(y x))
FreeVars2 = {FreeSet Expr2 nil}
{Browse FreeVars2} % Expected output: {y}



