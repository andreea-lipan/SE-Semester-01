% 2.
% Compute n^m where n is an integer and m is a natural number.
% Hint: Use the following inductive definition:
% n^0 = 1
% n^m = n * n^(m-1)

declare
fun {Putere N M}
   if M == 0 then 1
   else N * {Putere N M-1}
   end
end

declare A
A = {Putere 2 3}
{Browse A}