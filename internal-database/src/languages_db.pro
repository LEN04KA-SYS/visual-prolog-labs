domains 
    name, language = string 

database 
    language(language) 
    knows(name, language) 
    temp_knows(name, language)

predicates 
    nondeterm start 
    dialog 
    ask_about_languages(string) 
    confirm(char) 
    readfile 
    writefile 
    nondeterm show_queries 
    nondeterm count_and_show(string)
    copy_to_temp(string)
    nondeterm count_and_write_langs(integer, integer)

goal 
    start. 

clauses 
    start:- 
        readfile, 
        dialog, 
        writefile, 
        show_queries. 

    dialog:- 
        write("Enter your name: "), 
        readln(Name), 
        ask_about_languages(Name), 
        write("Data saved."), nl, nl. 

    ask_about_languages(Name):- 
        language(Lang), 
        write("Do you know "), write(Lang), write(" language? (y/n): "), 
        readchar(Answer), 
        write(Answer), nl, 
        confirm(Answer), 
        not(knows(Name, Lang)), 
        assert(knows(Name, Lang)), 
        fail. 
    ask_about_languages(_). 

    confirm('y'):- !. 
    confirm('Y'):- !. 
    confirm(_):- fail. 

    readfile:- 
        existfile("lang.dba"), 
        retractall(knows(_,_)), 
        consult("lang.dba"), 
        !. 
    readfile:- 
        not(language(_)),
        assert(language("russian")), 
        assert(language("english")), 
        assert(language("german")), 
        assert(language("french")), 
        assert(language("japanese")). 

    writefile:- 
        save("lang.dba"). 
    
    count_and_show(Name):-
        write(Name), write(" knows: "),
        retractall(temp_knows(_,_)),
        copy_to_temp(Name),
        count_and_write_langs(0, Count),
        write(" ("), write(Count), write(" languages)"), nl.
    
    copy_to_temp(Name):-
        knows(Name, Lang),
        assert(temp_knows(Name, Lang)),
        fail.
    copy_to_temp(_).
    
    count_and_write_langs(0, Count):-
        retract(temp_knows(_, Lang)),
        write(Lang),
        Acc1 = 1,
        count_and_write_langs(Acc1, Count).
    
    count_and_write_langs(Acc, Count):-
        Acc > 0,
        retract(temp_knows(_, Lang)),
        write(", "),
        write(Lang),
        Acc1 = Acc + 1,
        count_and_write_langs(Acc1, Count).
   
    count_and_write_langs(Count, Count).

    show_queries:- 
        write("Counting languages"), nl,
        count_and_show("Lena"),
        count_and_show("Polina"),
        nl.