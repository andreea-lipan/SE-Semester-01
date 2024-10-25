% 3.
% Compute the maximum of two natural numbers,
% knowing that the only allowed test with a
% conditional is the test whether a number is zero
% (that is, if N==0 then ... else ... end).
% Hint:Factsaboutthemaximum (n>=0 and m>=0)
% ■ max(n, m)=m, if n=0.
% ■ max(n, m)=n, if m=0.
% ■ max(n, m)=1 + max(n-1, m-1), otherwise.

declare
fun{MaxRecv N M}
   if N == 0 then M
   elseif M == 0 then N
   else 1 + {MaxRecv N-1 M-1}
   end
end

{Browse {MaxRecv 2 5}}