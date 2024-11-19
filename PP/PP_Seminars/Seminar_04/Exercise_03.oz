% Exercise 3. (Renaming)

% ----- Requirements ------
% The bound variables of 1am/let constructs do not carry any 
% meaning by themselves and are essentially place holders to 
% indicate binding of argument to corresponding identifiers.
% We can thus rename the bound identifiers without changing the
% meaning of a lambda term. For example, we have the following 
% equivalences:
% lam (z z) = lam(y y) = lam (a a)
% let (id#lam(z z) apply (id y)) = let (a#lam(b b) apply(a y))

% To carry out the renaming of bound identifiers, we must have 
% the ability to generate unique identifiers. Let us use a function
% New Id that would generate a unique identifier of the form id<n>,
% as defined below:
declare
Cnt = {NewCell 0}
fun {NewId}
    Cnt := @Cnt + 1
    {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

% This function uses a Cell object to obtain a running number that
% is incremented with each invocation to NewId. Each {NewId} call
% would give unique identifier with each invocation. We expect NewId
% function to work as follows:
%   {NewId}  %returns id<1>
%   {NewId}  %returns id<2>
%   {NewId}  %returns id<3>

% With the help of New Id, you are to define a function Rename that
% would return a new lambda term where the bound variables are 
% uniquely renamed, as highlighted below.
% {Rename lam (z lam (x z) )}
%       % returns lam(id<l> lam (id<2> id<1>))
% {Rename let (id#lam (z z) apply (id y))}
%       % returns let (id<3>#lam (id<4> id<4>) apply (id<3> y))


% ----- Solution ------
declare
fun {RenameWrap2 Expr Env}
    case Expr of 
         lam(X Body) then 
            local NewX in
                NewX = {NewId}
                lam(NewX {RenameWrap2 Body {Adjoin Env X#NewX}})
            end
        
        [] apply(E1 E2) then 
            apply({RenameWrap2 E1 Env} {RenameWrap2 E2 Env})
        
        [] let(X#Val Body) then 
            local NewX in 
                NewX = {NewId}
                let(NewX#{RenameWrap2 Val Env} {RenameWrap2 Body {Adjoin Env X#NewX}})
            end 
        [] X then
            if {IsMember Env X} then {Fetch Env X} else X end
        end
end


% ----- Examples -----
declare
fun {Rename2 Expr}
    {RenameWrap2 Expr nil}
end

% declare
% Expr1 = apply(let(x#v lam(y x)) y)
% {Browse {Rename2 Expr1}}

declare
Exmpl1 = lam(z lam(x z))
% {Browse {Rename2 Exmpl1}}


declare
Exmpl2 = let(id#lam(z z) apply(id y))
{Browse {Rename2 Exmpl2}}