% 1.
% Write a function Absthat computes the absolute value of a number.
% This should work for both integers and real numbers.

declare
fun {MyAbs1 X}
    if {Float.is X} then
        if X < 0.0 then ~X
        else X
        end
    else
        if X < 0 then ~X
        else X
        end
    end
end

fun {MyAbs2 X}
    if X > ~X then X
    else ~X
    end
end
    
{Browse {MyAbs1 ~1.1}}
{Browse {MyAbs2 ~1.1}}