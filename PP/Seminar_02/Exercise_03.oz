% Exercise 3. (Infinite Structures)

% ----- Requirements ------

% One of the advantages of lazy evaluation is the support for infinite 
% data structures. This may be useful for generating a list of infinite 
% prime numbers. Given below is a function to generate a list of prime
% numbers. If you run it, it will go into a LOOP. Modify it to make it lazy.
% After that, use it to write a function {GetAfter N} that would return
% the first prime number after a given value.

% Applies filter for every elem
declare fun {Sieve L}
    case L of
       nil then nil
    [] H|T then H|{Sieve {Filter T H}}
    end
end

% Filter out the multiples of H
declare fun {Filter L H}
    case L of 
       nil then nil
    [] A|As then 
        if (A mod H) == 0 then
                {Filter As H}
        else 
            A|{Filter As H}
        end
    end
end

fun {Prime} {Sieve {Gen 2}} end 
fun {Gen N} N|{Gen N+1} end

%{Browse {Prime}}


% ----- Solution ------

% Lazy version of Filter
declare fun lazy {FilterLazy L H}
    case L of 
       nil then nil
    [] A|As then 
        if (A mod H) == 0 then
                {FilterLazy As H}
        else 
            A|{FilterLazy As H}
        end
    end
end

% Lazy version of Sieve
declare fun lazy {SieveLazy L}
    case L of
       nil then nil
    [] H|T then H|{SieveLazy {FilterLazy T H}}
    end
end

% Gaseste primul elem din lista mai mare ca N
fun {GetAfterImpl N Lista} 
    case Lista of 
        H|T then 
            if H > N then 
                H 
            else 
                {GetAfterImpl N T}
            end
        end
end

% Genereaza lista infinita
fun lazy {GenLazy N} 
    N|{GenLazy N+1} 
end

% Genereaza lista de nr prime lazy
fun lazy {PrimeLazy} 
    {SieveLazy {GenLazy 2}} 
end 

declare PrimeNumers = {PrimeLazy}

% Returneaza primul nr prim mai mare ca N
fun {GetAfter N} 
    {GetAfterImpl N PrimeNumers}
end


% ----- Examples ------

{Browse 'First prime nr after 10: '}
{Browse {GetAfter 10}}   % 11

{Browse 'First prime nr after 100: '}
{Browse {GetAfter 100}}  % 101

{Browse 'First prime nr after 456: '}
{Browse {GetAfter 456}}  % 457