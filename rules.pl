test(Plan) :-
    write('Initial state:'), nl,
    Init = [at(tile7,9), at(tile1,8), at(tile5,7), at(tile6,6), at(tile2,5), at(empty,4), at(tile8,3), at(tile3,2), at(tile4,1)],
    write_sol(Init),
    Goal = [at(tile1,1), at(tile2,2), at(tile3,3), at(tile4,4), at(empty,5), at(tile5,6), at(tile6,7), at(tile7,8), at(tile8,9)],
    nl, write('Goal state:'), nl,
    write(Goal), nl, nl,
    solve(Init, Goal, Plan).

solve(State, Goal, Plan) :-
    solve(State, Goal, [], Plan).

is_movable(X1, Y1, X2, Y2) :-
    (X1 =:= X2, abs(Y1 - Y2) =:= 1) ;
    (Y1 =:= Y2, abs(X1 - X2) =:= 1).

solve(State, Goal, Plan, Plan) :-
    is_subset(Goal, State), nl,
    write_sol(Plan).

solve(State, Goal, Sofar, Plan) :-
    act(Action, Preconditions, Delete, Add),
    is_subset(Preconditions, State),
    \+ member(Action, Sofar),
    delete_list(Delete, State, Remainder),
    append(Add, Remainder, NewState),
    solve(NewState, Goal, [Action | Sofar], Plan).

act(move(X, Y, Z),
    [at(tile, X, Y), at(empty, Z), is_movable(X, Y, Z, _), \+ X =:= 2, \+ Z =:= 2],
    [at(tile, X, Y), at(empty, Z)],
    [at(tile, Z, Y), at(empty, X)]).

is_subset([H | T], Set) :-
    member(H, Set),
    is_subset(T, Set).
is_subset([], _).

delete_list([H | T], Curstate, Newstate) :-
    remove(H, Curstate, Remainder),
    delete_list(T, Remainder, Newstate).
delete_list([], Curstate, Curstate).

remove(X, [X | T], T).
remove(X, [H | T], [H | R]) :-
    remove(X, T, R).

write_sol([]).
write_sol([H | T]) :-
    write_sol(T),
    write(H), nl.

append([H | T], L1, [H | L2]) :-
    append(T, L1, L2).
append([], L, L).

member(X, [X | _]).
member(X, [_ | T]) :-
    member(X, T).
