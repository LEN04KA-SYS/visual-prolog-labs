DOMAINS
    tree = empty; tr(integer, tree, tree)
    formula = true; false; var(symbol); or(formula, formula); and(formula, formula)
    list = symbol*

PREDICATES
    isotree(tree, tree)
    isotree_cut(tree, tree)
    test_iso
    simplify(formula, formula)
    write_formula(formula)
    test_logic

CLAUSES
    % izomorfizm bez otsecheniya
    isotree(empty, empty).
    isotree(tr(X, L1, R1), tr(X, L2, R2)) :- 
        isotree(L1, L2), 
        isotree(R1, R2).
    isotree(tr(X, L1, R1), tr(X, L2, R2)) :- 
        isotree(L1, R2), 
        isotree(R1, L2).

    % izomorfizm s otsecheniyami
    isotree_cut(empty, empty) :- !.
    isotree_cut(tr(X, L1, R1), tr(X, L2, R2)) :- 
        !, 
        isotree_cut(L1, L2), 
        isotree_cut(R1, R2).
    isotree_cut(tr(X, L1, R1), tr(X, L2, R2)) :- 
        isotree_cut(L1, R2), 
        isotree_cut(R1, L2).

    test_iso :-
        Tree1 = tr(1, tr(2, empty, empty), tr(3, empty, empty)),
        Tree2 = tr(1, tr(3, empty, empty), tr(2, empty, empty)),
        
        write("Test 1 (bez cut): "), 
        isotree(Tree1, Tree2), write("Izomorfny"), nl, fail;
        write("Net"), nl.
        
    test_iso :-
        Tree1 = tr(1, tr(2, empty, empty), tr(3, empty, empty)),
        Tree2 = tr(1, tr(3, empty, empty), tr(2, empty, empty)),
        
        write("Test 1 (s cut):   "), 
        isotree_cut(Tree1, Tree2), write("Izomorfny"), nl, fail;
        write("Net"), nl.

    % Preobrazovanie formuly
    % True or F = true
    simplify(or(true, _), true) :- !.
    simplify(or(_, true), true) :- !.
    
    % False and F = false
    simplify(and(false, _), false) :- !.
    simplify(and(_, false), false) :- !.
    
    % Rekursivnyi spusk
    simplify(or(F1, F2), or(S1, S2)) :- 
        !, 
        simplify(F1, S1), 
        simplify(F2, S2).
        
    simplify(and(F1, F2), and(S1, S2)) :- 
        !, 
        simplify(F1, S1), 
        simplify(F2, S2).
        
    simplify(F, F).

    % Vyvod formuly
    write_formula(true) :- write("true").
    write_formula(false) :- write("false").
    write_formula(var(X)) :- write(X).
    write_formula(or(A, B)) :- 
        write("("), write_formula(A), write(" | "), write_formula(B), write(")").
    write_formula(and(A, B)) :- 
        write("("), write_formula(A), write(" & "), write_formula(B), write(")").

    test_logic :-
        F1 = or(true, and(var(a), var(b))),
        write("Ishodnaya formula: "), write_formula(F1), nl,
        simplify(F1, F2),
        write("Preobrazovannaya:  "), write_formula(F2), nl, nl,
        
        F3 = and(false, or(var(x), var(y))),
        write("Ishodnaya formula: "), write_formula(F3), nl,
        simplify(F3, F4),
        write("Preobrazovannaya:  "), write_formula(F4), nl, nl,
        
        F5 = or(var(p), and(false, var(q))),
        write("Ishodnaya formula: "), write_formula(F5), nl,
        simplify(F5, F6),
        write("Preobrazovannaya:  "), write_formula(F6), nl, nl.

GOAL
    write("===== ISSLEDOVANIE 1: IZOMORFIZM DEREVJEV ====="), nl,
    test_iso, nl, nl,
    
    write("===== INDIVIDUALNOE ZADANIE 1: UPROSCHENIE FORMUL ====="), nl,
    test_logic.