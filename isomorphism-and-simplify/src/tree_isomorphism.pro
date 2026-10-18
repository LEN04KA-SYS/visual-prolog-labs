DOMAINS
    tree = empty; tr(integer, tree, tree)

PREDICATES
    nondeterm isotree(tree, tree)

CLAUSES
    % Oba dereva pusty
    isotree(empty, empty) :- !.
    
    % Korni ravny, podderevya izomorfny v pryamom poryadke
    isotree(tr(X, L1, R1), tr(X, L2, R2)) :- 
        isotree(L1, L2), 
        isotree(R1, R2), 
        !.
        
    % Korni ravny, podderevya izomorfny v obratnom poryadke
    isotree(tr(X, L1, R1), tr(X, L2, R2)) :- 
        isotree(L1, R2), 
        isotree(R1, L2), 
        !.

GOAL
    write("Izomorfnye trees"), nl,
    
    % Iz
    Tree1 = tr(1, tr(2, tr(4, empty, empty), empty), tr(3, empty, tr(5, empty, empty))),
    Tree2 = tr(1, tr(3, tr(5, empty, empty), empty), tr(2, empty, tr(4, empty, empty))),
    
    % Ne iz
    % Tree1 = tr(1, tr(2, tr(4, empty, empty), tr(5, empty, empty)), tr(3, empty, tr(6, empty, empty))),
    % Tree2 = tr(1, tr(2, tr(4, empty, empty), empty), tr(3, tr(5, empty, empty), tr(6, empty, empty))),
    
    write("Resheniya:"), nl,
    isotree(Tree1, Tree2), write("  - izomorfny"), nl.