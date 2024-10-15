% Exercise 4. (Binary Search Tree)


% ----- Requirements ------


% Consider a binary search tree (BST) data structure of the following form:

% <BTree> ::= leaf(<Int>) | node(<Int>, <BTree>, <BTree>)

% The elements of this tree are assumed to be sorted if 
% it has the following properties:
%   a. It is a leaf node with an integer value.
%   b. It is a node where the left and right subtrees are sorted, and
%      all integers in its left subtree are less than the integer in 
%      the current node, and all integers in current node are <= to all
%      integers in the right subtree.

% A simple example of this BST data structure is the followinw:

%   N1 = node(3 nil N2)
%   N2 = node(5 nil nil)

%                3
%                 \
%                  5

% Implement the following methods that manipulate/query the BST:

% (i) Insert :: {<BTree>, <Int>} -> <BTree>
%  inserts an integer into the BST

% (ii) Smallest :: <BTree> -> <Int>
%  searches the samllest element of the given BST

% (iii) Biggest :: <BTree> -> <Int>
%  searches the largest element of the given BST

% (iv) IsSortedBST :: <BTree> -> <Bool>
%  checks if the given tree has the sorted property
% hint: may use smallest/biggest functions method



% ----- Solution ------


% Inserts a new node in tree
declare
fun {Insert Tree Node} 
    case Tree of nil then node(Node nil nil)
    [] node(Value Left Right) then 
        if (Node < Value) then 
            node(Value {Insert Left Node} Right)
        else 
            node(Value Left{Insert Right Node})
        end
    end
end

% Searches for the smallest element in the tree
declare
fun {Smallest Root}
    case Root of nil then nil
    [] node(Value nil _) then Value
    [] node(Value Left _) then {Smallest Left}
    end
end

% Searches for the biggest element in the tree
declare
fun {Biggest Root}
    case Root of nil then nil
    [] node(Value _ nil) then Value
    [] node(Value _ Right) then {Biggest Right}
    end
end

% Checks if the tree is sorted
declare
fun {IsSortedBST Tre} 
    case Tre of nil then true
    [] node(Value nil nil) then true
    [] node(Value nil Right) then 
        if Value > {Smallest Right} then false
        else {IsSortedBST Right}
        end
    [] node(Value Left nil) then 
        if Value < {Biggest Left} then false
        else {IsSortedBST Left}
        end
    [] node(Value Left Right) then 
        if {Biggest Left} < Value andthen Value < {Smallest Right} then 
            {IsSortedBST Left} andthen {IsSortedBST Right}
        else false
        end
    end
end


% ----- Examples ------

% declare tree
declare TreeKool = {NewCell nil}

%          5
%         / \
%        3   7
%       / \
%      2   4

% insert
TreeKool := {Insert @TreeKool 5}
TreeKool := {Insert @TreeKool 3}
TreeKool := {Insert @TreeKool 7}
TreeKool := {Insert @TreeKool 2}
TreeKool := {Insert @TreeKool 4}
{Browse @TreeKool}

% smallest
{Browse {Smallest @TreeKool}}

% biggest
{Browse {Biggest @TreeKool}}

% is sorted
{Browse {IsSortedBST @TreeKool}}