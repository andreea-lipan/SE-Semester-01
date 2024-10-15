
declare TreeKool = {NewCell nil}

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

TreeKool := {Insert @TreeKool 2}
{Browse @TreeKool}

TreeKool := {Insert @TreeKool 5}
TreeKool := {Insert @TreeKool 3}
TreeKool := {Insert @TreeKool 7}

fun {IsSortedBST Tre} 
    case Tre of nil then true
    [] node(Value nil nil) then true
    [] node(Value nil Right) then 
        if Value < {Smallest Right} then false
        else {IsSortedBST Right}
        end
    [] node(Value Left nil) then 
        if {Biggest Left} < Value then false
        else {IsSortedBST Left}
        end
    [] node(Value Left Right) then 
        if {Biggest Left} < Value and Value < {Smallest Right} then 
            {IsSortedBST Left} and {IsSortedBST Right}
        else false
        end
    end
end

{Browse @TreeKool}