% This is an attempt of Exercise 3 without using the Env
% it kinda works? i think it had some bug but idk


declare
Cnt={NewCell 0}
fun {NewId}
    Cnt:=@Cnt+1
    {String.toAtom {Append "id<" {Append {Int.toString @Cnt} ">"}}}
end

declare
fun {RenameSub Expr OldVar NewVar}
    case Expr of lam(X Body) then
        if X == OldVar then {Rename Expr}
        else
            local NewX in
                NewX={NewId}
                lam(NewX {RenameSub {RenameSub Body X NewX} OldVar NewVar})
            end
        end
    [] apply(E1 E2) then
        apply({RenameSub E1 OldVar NewVar} {RenameSub E2 OldVar NewVar})
    [] let(X#Val Body) then
        if X == OldVar then {Rename Expr}
        else
            local NewX in
                NewX = {NewId}
                let(NewX#{RenameSub Val OldVar NewVar} {RenameSub {RenameSub Body X NewX} OldVar NewVar})
                % let(NewX#({RenameSub Value OldVar NewVar}) {RenameSub {RenameSub Body X NewX} OldVar NewVar})
            end
        end
    [] X then 
        if X==OldVar then NewVar else X end
    end
end

declare
fun {Rename Expr}
    case Expr of lam(X Body) then
        local NewX in
            NewX = {NewId}
            lam(NewX {RenameSub Body X NewX})
        end
    [] apply(E1 E2) then
        apply({Rename E1} {Rename E2})
    [] let(X#Val Body) then
        local NewX in
            NewX = {NewId}
            let(NewX#{Rename Val} {RenameSub Body X NewX})
        end
    else
        Expr
    end
end

% declare
% Expr = lam(a lam(b lam(c c)))
% {Browse {Rename Expr}}

% declare
% Expr2 = apply(lam(a apply(a a)) lam(d apply(d lam(c d))))
% {Browse {Rename Expr2}}


% declare
% Expr3 = let(id#lam(z z) apply(id y))
% {Browse {Rename Expr3}}



% declare
% Expr1 = lam(z lam(z z))
% Expr2 = let(id#lam(z z) apply(id y))

% {Browse {Rename Expr1}}  % Expected output: lam(id1 lam(id2 id2))
% {Browse {Rename Expr2}}  % Expected output: let(id3#lam(id4 id4) apply(id3 y))


declare
Expr1 = apply(let(x#v lam(y x)) y)
% {Browse {Rename Expr1}}

declare
Expr2 = apply(lam(x apply(lam(y x) y)) x)
% {Browse {Rename Expr2}}

declare
Expr3 = let(x#apply(f lam(y x)) apply(g y))
% {Browse {Rename Expr3}}

declare
Expr4 = lam(x apply(let(y#z apply(x y)) x))
% {Browse {Rename Expr4}}

declare
Expr5 = apply(lam(x let(y#apply(lam(z x) y) z)) y)
% {Browse {Rename Expr5}}

declare
Expr6 = let(x#apply(f x) let(y#apply(g y) x))
{Browse {Rename Expr6}}


% {Browse {Rename let(id#la m(z z) apply(id y))}}