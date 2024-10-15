% Exercise 2.

% ----- Requirements ------


% Given a list L=[x1 x2 ... xN], its reverse woulf be [xN xN-1 ... x1].
% One standard way of writing such a reverse function is shown below.
% If you exec 
%      {ResverseList ['I' 'want' 2 go 'there']}
% you should get 
%      ['there' go 2 'want' 'I'].

declare fun {Append L1 L2}
    case L1 of
       nil then L2
    [] H|T then H|{Append T L2}
    end
end

declare fun {ReverseList L}
    case L of 
       nil then nil
    [] H|T then {Append {ReverseList T} [H]}
    end
end

% However, this implementation has quadratic time complexity since 
% each Append call takes time that is linear to its first argument. 
% Using a second parameter that contains the partially reversed list, 
% write another definition of Reverse that is more efficient, 
% without using Append calls.


% ----- Solution ------

declare fun {ReverseList2Aux L R}
    case L of 
       nil then R
    [] H|T then {ReverseList2Aux T H|R}
    end
end

declare fun {ReverseList2 L}
    {ReverseList2Aux L nil}
end


% ----- Examples ------

{Browse {ReverseList2 ['I' 'want' 2 go 'there']}}