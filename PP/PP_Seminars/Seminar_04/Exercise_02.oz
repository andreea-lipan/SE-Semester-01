% Exercise 2. (Environment/Mapping)

% ----- Requirements ------
% During the evaluation of a lambda term, we often build an environment for the identifiers
% that map each given variable to its corresponding argument. We can capture this mapping 
% as a list of pairs of the form ‹Env>=<List> (<Id>#<Expr>). To support this environment 
% data structure, we may provide the following functions:
% IsMember :: (<Env> <Id>} → <Boolean>
% Fetch :: {<Env> <Id>} → <Expr>
% Adjoin :: {<Env> <Id>#<Expr>} → <Expr>
% The IsMember function checks if a given identifier is present in the current environment,
% while Fetch will return the expression of the present identifier from the environment. 
% If the identifier is not present, the original identifier is returned unchanged. 
% Finally, the Adjoin function will add a new pair into the environment that overrides 
% a previous mapping of the identifier, if it exists. Some examples are given below:
% {IsMember [a#E1 b#y c#E3] c}  % returns true
% {IsMember [a#E1 b#y c#E3] y}  % returns false
% {Fetch [a#El b#y c#E3] c }    % returns E3
% {Fetch [a#El b#y c#E3] d }    % returns d
% {Adjoin [a#E1 b#y c#E3] c#E4} % [c#E4 a#E1 b#y]
% {Adjoin [a#E1 b#y c#E3] d#E4} %[d#E4 a#E1 b#y c#E3]


% ----- Solution ------
declare
fun {IsMember Env Id}
    case Env of nil then false
    [] H#V | Env then
        if H==Id then true else {IsMember Env Id}
        end
    end
end

declare
fun {Fetch Env Id}
    case Env of nil then Id
    [] H#V | Env then
        if H==Id then V else {Fetch Env Id}
        end
    end
end

declare
fun {Adjoin Env Pair}
    case Env of nil then Pair | Env
    [] H#V | Env then
        case Pair of Id#NewValue then
            if H == Id then {Adjoin Env Pair}
            else H#V | {Adjoin Env Pair}
            end
        end
    end
end


% ----- Examples -----
declare
Env = [a#1 b#y c#3]
{Browse {IsMember Env c}}
{Browse {IsMember Env y}}
{Browse {Fetch Env c}}
{Browse {Fetch Env d}}
{Browse {Adjoin Env b#4}}