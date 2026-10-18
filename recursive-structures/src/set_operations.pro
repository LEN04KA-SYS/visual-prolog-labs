domains
    element = integer
    set = element*
    pair = pair(element, element)
    pair_set = pair*

predicates
    nondeterm member(element, set)
    append(set, set, set)
    append_pairs(pair_set, pair_set, pair_set)
    union(set, set, set)
    nondeterm intersection(set, set, set)
    subtraction(set, set, set)
    cartesian_product(set, set, pair_set)
    add_unique(set, set, set, set)
    make_pairs(element, set, pair_set)
    write_set(set)
    write_pair_set(pair_set)
    n_element (integer, set, element)
    nondeterm start

clauses
    member(X, [X | _]).
    member(X, [_ | T]) :- member(X, T).

    append([], L, L).
    append([H | T], L, [H | R]) :- append(T, L, R).

    append_pairs([], L, L).
    append_pairs([H | T], L, [H | R]) :- append_pairs(T, L, R).

    union(A, B, Result) :-
        append(A, [], Temp),
        add_unique(B, A, Temp, Result).

    add_unique([], _, Res, Res).
    add_unique([H | T], SetA, Current, Result) :-
        member(H, SetA),
        !,
        add_unique(T, SetA, Current, Result).
    add_unique([H | T], SetA, Current, Result) :-
        append(Current, [H], NewCurrent),
        add_unique(T, SetA, NewCurrent, Result).

    intersection(_, [], []).
    intersection([], _, []).
    intersection([H | T], B, [H | Res]) :-
        member(H, B),
        !,
        intersection(T, B, Res).
    intersection([_ | T], B, Res) :-
        intersection(T, B, Res).

    subtraction([], _, []).
    subtraction([H | T], B, Res) :-
        member(H, B),
        !,
        subtraction(T, B, Res).
    subtraction([H | T], B, [H | Res]) :-
        subtraction(T, B, Res).

    cartesian_product([], _, []).
    cartesian_product([H | T], B, Result) :-
        cartesian_product(T, B, Rest),
        make_pairs(H, B, Pairs),
        append_pairs(Pairs, Rest, Result).

    make_pairs(_, [], []).
    make_pairs(X, [Y | T], [pair(X, Y) | Rest]) :-
        make_pairs(X, T, Rest).

    write_set(S) :-
        write(S), nl.

    write_pair_set(PS) :-
        write(PS), nl.
        
    n_element(1, [H | _], H) :- !.
    n_element(N, [_ | T], Res) :-
        N > 1,
        N1 = N - 1,
        n_element(N1, T, Res).

    start :-
        A = [5, 7, 13, 14],
        B = [13, 14, 22],

        write(" A = "), write_set(A),
        write(" B = "), write_set(B), nl,

        union(A, B, U),
        write(" Objedinenie: "), write_set(U),

        intersection(A, B, I),
        write(" Peresechenie: "), write_set(I),

        subtraction(A, B, S1),
        write(" Vychitanie (A\\B): "), write_set(S1),

        subtraction(B, A, S2),
        write(" Vychitanie (B\\A): "), write_set(S2),

        cartesian_product(A, B, C),
        write(" Dekartovo proizvedenie: "), write_pair_set(C), nl,
        
        n_element(2, A, El),
        write(" 2 element A: "), write(El), nl,
        n_element(3, B, E2),
        write(" 3 element B: "), write(E2), nl.

goal
    start.