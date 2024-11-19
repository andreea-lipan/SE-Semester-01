% Exercise 5.  (Arithmetic Expressions Evaluation)

% ----- Requirements ------
% Suppose that you are given an arithmetic expression 
% described by a tree constructed from tuples as follows: 
% 1. An integer is described by a tuple int(N), where N is an integer. 
% 2. An addition is described by a tuple add(X Y), where both 
% X and Y are arithmetic expressions. 
% 3. A multiplication is described by a tuple mul(X Y), where 
% both X and Y are arithmetic expressions. 
% Implement a function Eval that takes an arithmetic expression 
% and returns its value. For example, 
% add(int(1) mul(int(3) int(4))) is an arithmetic expression and 
% its evaluation returns 13.


% ----- Solution ------
declare
fun {Eval F} 
    case F of 
       int(X) then X
    [] add(X Y) then {Eval X} + {Eval Y}
    [] mul(X Y) then {Eval X} * {Eval Y}    
    end
end


% ----- Example ------
declare
Expr = mul(int(4) add(int(1) int(3)))
{Browse {Eval Expr}}
