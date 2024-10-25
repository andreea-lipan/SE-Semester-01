% Exercise 1. (Combinations)

% ---- base solution  ------

declare fun {Fact N}
    if N == 0.0 then 
        1.0
    else 
        N * {Fact N-1.0}
    end
end

declare fun {Comb1 N K}
    {Fact N} / ({Fact K} * {Fact N-K})
end

% ----- (a) ------

declare fun {Multiply Start End}
    if Start == End then
        Start
    else 
        Start * {Multiply Start-1.0 End}
    end
end

declare fun {Comb2 N K} Nominator Denominator in
    Nominator = {Multiply N (N-K+1.0)}
    Denominator = {Fact K}
    Nominator / Denominator
end


% ----- (b) ------

declare fun {CombImpl Nominator Denominator}
    if Denominator == 1.0 then
        Nominator
    else
        (Nominator / Denominator) 
            * {CombImpl (Nominator + 1.0) (Denominator - 1.0)}
    end
end

declare fun {Comb3 N K} 
    {CombImpl (N-K+1.0) (K)}
end

%  -----  Examples  ------

declare 
A = 10.0
B = 2.0

{Browse '(base)'}
{Browse {Comb1 A B}}
{Browse '(a)'}
{Browse {Comb2 A B}}
{Browse '(b)'}
{Browse {Comb3 A B}}
