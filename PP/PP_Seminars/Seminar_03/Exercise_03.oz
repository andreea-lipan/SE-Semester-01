% Exercise 3. (Zip and UnZip)

% ----- Requirements ------
% The operation a # b constructs a tuple with label ’#’ and 
% fields a and b which is also known as a pair. We can use 
% it to implement lists-of-pairs, e.g [a#1 b#2 c#3]. A 
% different view of this data structure is known as a 
% pair-of-lists, e.g [a b c]#[1 2 3]. Two important functions 
% that convert list-of-pairs to pair-of-lists and vice versa 
% are Zip and UnZip. 
% a) Implement a function Zip that takes a pair Xs#Ys of two 
% lists Xs and Ys (of the same length) and returns a pairlist, 
% where the first field of each pair is taken from Xs and the 
% second from Ys. For example, {Zip [a b c]#[1 2 3]} returns the 
% pairlist [a#1 b#2 c#3]. 
% b) The function UnZip does the inverse, for example 
% {UnZip [a#1 b#2 c#3]} returns [a b c]#[1 2 3]. Give a 
% specification and implementation of UnZip. 


% ----- Solution Zip------
declare
fun {ZipWrap Xs Ys}
    case Xs of nil then nil
    [] X | Xs then 
        case Ys of Y | Ys then X#Y | {ZipWrap Xs Ys}
        end
    end
end

declare
fun {Zip Pair}
    case Pair of Xs#Ys then {ZipWrap Xs Ys} end
end


% ----- Example Zip ------
declare
A = [a b c]#[1 2 3]
{Browse {Zip A}}


% ----- Solution UnZip------
declare fun {ReverseListAux L R}
    case L of 
       nil then R
    [] H|T then {ReverseListAux T H|R}
    end
end

declare fun {ReverseList L}
    {ReverseListAux L nil}
end

declare
fun {UnZipWrap List Xs Ys}
    case List of nil then {ReverseList Xs}#{ReverseList Ys}
    [] L | List then 
        case L of X#Y then {UnZipWrap List X|Xs Y|Ys}
        end
    end
end

declare
fun {UnZip List}
    {UnZipWrap List nil nil}
end


% ----- Example UnZip ------
declare
A = [a#1 b#2 c#3]
{Browse {UnZip A}}