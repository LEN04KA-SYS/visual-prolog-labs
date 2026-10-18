domains
    vertex = symbol
    weight = integer
    edge_undirected = e(vertex, vertex)
    edge_weighted = e(vertex, vertex, weight)
    vertex_list = vertex*
    edge_list_undirected = edge_undirected*
    edge_list_weighted = edge_weighted*

predicates
    % a (neorient)
    % 1. Facts 
    edge_a_facts(vertex, vertex)
    % 2. Spisok struktur
    graph_a_struct_list(edge_list_undirected)
    % 3. Spisok vershin i spisok reber
    graph_a_vertices(vertex_list)
    graph_a_edges_list(edge_list_undirected)

    % b (orient)
    % 1. Facts 
    edge_b_facts(vertex, vertex, weight)
    % 2: Spisok struktur
    graph_b_struct_list(edge_list_weighted)
    % 3. Spisok vershin i spisok reber
    graph_b_vertices(vertex_list)
    graph_b_edges_list(edge_list_weighted)

clauses
    % a
    % 1. Facts 
    edge_a_facts(a, b). edge_a_facts(b, a).
    edge_a_facts(b, c). edge_a_facts(c, b).
    edge_a_facts(b, d). edge_a_facts(d, b).
    edge_a_facts(c, d). edge_a_facts(d, c).
    
    % 2: Spisok struktur
    graph_a_struct_list([e(a,b), e(b,c), e(b,d), e(c,d)]).
    
    % 3. Spisok vershin i spisok reber
    graph_a_vertices([a, b, c, d]).
    graph_a_edges_list([e(a,b), e(b,c), e(b,d), e(c,d)]).
    
    % b
    % 1. Facts 
    edge_b_facts(s, t, 3).
    edge_b_facts(t, v, 1).
    edge_b_facts(t, u, 5).
    edge_b_facts(v, u, 2).
    edge_b_facts(u, t, 2).
    
    % 2: Spisok struktur
    graph_b_struct_list([e(s,t,3), e(t,v,1), e(t,u,5), e(v,u,2), e(u,t,2)]).
    
    % 3. Spisok vershin i spisok reber
    graph_b_vertices([s, t, u, v]).
    graph_b_edges_list([e(s,t,3), e(t,v,1), e(t,u,5), e(v,u,2), e(u,t,2)]).

goal
    write("Graph a:\n"),
    graph_a_struct_list(L1), write("  Spisok struktur: "), write(L1), nl,
    graph_a_vertices(V), graph_a_edges_list(L2),
    write("  Versh: "), write(V), nl,
    write("  Rebra: "), write(L2), nl, nl,
    
    write("Graph b:\n"),
    graph_b_struct_list(L3), write("  Spisok struktur: "), write(L3), nl,
    graph_b_vertices(V2), graph_b_edges_list(L4),
    write("  Versh: "), write(V2), nl,
    write("  Rebra: "), write(L4), nl, nl.