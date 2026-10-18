DOMAINS
    formula = true; false; v(symbol); d(formula, formula); c(formula, formula)

PREDICATES
    simplify(formula, formula)
    write_f(formula)

CLAUSES
    % True | F = true
    simplify(d(true, _), true) :- !.
    simplify(d(_, true), true) :- !.
    
    % False & F = false
    simplify(c(false, _), false) :- !.
    simplify(c(_, false), false) :- !.
    
    % Rekursivnyi spusk dlya dizyunktsii
    simplify(d(F1, F2), d(S1, S2)) :- 
        !,
        simplify(F1, S1), 
        simplify(F2, S2).
    
    % Rekursivnyi spusk dlya konyunktsii
    simplify(c(F1, F2), c(S1, S2)) :- 
        !,
        simplify(F1, S1), 
        simplify(F2, S2).
    
    % Bazovyi sluchai
    simplify(F, F).
    
    write_f(true) :- write("true").
    write_f(false) :- write("false").
    write_f(v(X)) :- write(X).
    write_f(d(A, B)) :- 
        write("("), write_f(A), write(" | "), write_f(B), write(")").
    write_f(c(A, B)) :- 
        write("("), write_f(A), write(" & "), write_f(B), write(")").

GOAL
    write("#1. F1 = true | (a & b)"), nl,
    simplify(d(true, c(v(a), v(b))), F2),
    write("      F2 = "), write_f(F2), nl, nl,
    
    write("#2. F1 = false & (x | y)"), nl,
    simplify(c(false, d(v(x), v(y))), F4),
    write("      F2 = "), write_f(F4), nl, nl,

    write("#3. F1 = p | (false & q)"), nl,
    simplify(d(v(p), c(false, v(q))), F6),
    write("      F2 = "), write_f(F6), nl, nl,

    write("#4. F1 = (true | x) & y"), nl,
    simplify(c(d(true, v(x)), v(y)), F8),
    write("      F2 = "), write_f(F8), nl, nl,

    write("#5. F1 = (false & a) | b"), nl,
    simplify(d(c(false, v(a)), v(b)), F10),
    write("      F2 = "), write_f(F10), nl, nl.