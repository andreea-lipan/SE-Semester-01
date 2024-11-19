% Exercise 4. (Substitution)

% ----- Requirements ------
% Lambda terms are essentially evaluated with the help of 
% substitution. We can implement such substitution with the 
% following function:
%       Subs :: (<Id>#<Expr> <Expr>} → ‹Expr>
% Using this function, we may reduce each application by 
% substituting the argument for its parameter in the function's 
% body. For example, the lambda term 
%       apply (lam(x apply (x y)) lam(x x))
% can be reduced by the following substitution process.
%       = {Subs x#lam(x x) apply (x y) }
%       = apply (lam (x x) y)

% When applying substitution, we should always substitute only the
%  free occurrences of its identifier in the main expression. We 
% must ensure that the bound identifiers of the same name are not
% substituted. For example, the third occurrence of x below is not
% substituted as it is bound to an inner lambda term:
%    {Subs x#lam(z z) apply(x lam(x apply (x z) )) }
%    = apply (lam(z z) lam(x apply(x z)))

% Another subtlety with substitution is that the free variables of
% the argument to substitute into a given expression must not clash
% with the bound variables of the latter. For example, the 
% substitution below has such a clash as the free variable z of the
% argument lam (y z) clashes with the bound identifier of lam (z apply (x z) ).
%     {Subs x#lam(y z) apply(x lam(z apply (x z) )) }
% If we apply the substitution in a naïve way, we will get the 
% following result:
%     apply ((lam y z) lam(z apply ( (lam y z) z)))
% where the third occurrence of z is now bound when it should have been free.

% One solution to this problem is to rename each lambda term whose
% bound variable clashes with the free variables of the argument
% being substituted. In the above example, we should rename the
% lambda term as follows:
%    {Rename lam (z apply (x z)) } 
%    = lam (id<1> apply (x id<1>) )
% After this renaming, we can apply substitution in a safe manner,
% as follows:
%    {Subs x#lam (y z) apply (x lam (id<1> apply (x id<1>))) }
%    = apply (lam(y z) lam(id<1> apply ( (lam y z) id<1>)))
% Implement a Subs function which adheres to the above stated conditions.


% ----- Solution ------
declare
fun {SubsWrap Var SubExpr Expr}
    case Expr of

       lam(X Body) then                         % Case 1: Expr is a lambda expression lam(X Body)
          if X == Var then
             lam(X Body)                        % X is bound in this lambda, so skip SubsWraptitution in the body
          else
             lam(X {SubsWrap Var SubExpr Body}) % SubsWraptitute in the body of the lambda
          end
 
        [] apply(Func Arg) then                                          % Case 2: Expr is an application apply(Func Arg)
          apply({SubsWrap Var SubExpr Func} {SubsWrap Var SubExpr Arg})  % SubsWraptitute in both the function and the argument expressions
       
        [] let(X#Value Body) then                                             % Case 4: Expr is a let expression let(X#Value Body)
          if X == Var then
             let(X# {SubsWrap Var SubExpr Value} Body)                        % X is bound in this let, so skip SubsWraptitution in the body
          else
             let(X# {SubsWrap Var SubExpr Value} {SubsWrap Var SubExpr Body}) % SubsWraptitute in both Value and Body
          end
 
        [] X then                 % Case 3: Expr is an identifier (id(X))
           if X == Var then
              SubExpr             % Substitute if X matches the variable
           else
              X                   % Otherwise, leave it unchanged
           end
  
       else
          Expr     % Default case: Return expression unchanged if it doesn’t match any form
    end
 end

 % Wrapper class
 declare
 fun {Subs Pair Expr}
    case Pair of Var#SubExpr then 
        {SubsWrap Var SubExpr Expr}
    end
 end
 

 % ----- Examples -----
declare
Expr11 = apply(x lam(x apply(x z)))
% {Browse {Subs x#lam(x x) {Rename Expr11}}}

declare
Expr22 = apply(x lam(z apply(x z)))
{Browse {Subs x#lam(y z) {Rename Expr22}}}