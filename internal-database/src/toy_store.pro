domains
    name = string
    price, agemin, agemax = integer

database
    toy(name, price, agemin, agemax)

predicates
    start
    dialog
    showmenu
    mainloop
    processmenu(integer)
    addtoy
    deletetoy
    showall
    readfile
    writefile
    query1
    query2
    query3
    query4
    query5
    query6
    query7
    query8
    query9
    getname(string)
    getprice(integer)
    getagemin(integer)
    getagemax(integer)
    confirm(char)
    nondeterm maxprice(integer)
    nondeterm higherprice(integer)

goal
    start.

clauses
    start:-
        readfile,
        dialog.

    dialog:-
        showmenu,
        mainloop.

    mainloop:-
        write("Select menu item (1-13): "),
        readint(Choice),
        processmenu(Choice),
        mainloop.

    showmenu:-
        nl, write("MENU"), nl, nl,
        write("1. Add toy"), nl,
        write("2. Delete toy"), nl,
        write("3. Show all toys"), nl,
        write("4. Exit"), nl, nl,
        write("Queries:"), nl,
        write("5. Toys price <= 400 rub. for children 5 years"), nl,
        write("6. Toys for children 4 and 10 years"), nl,
        write("7. Prices of all cubes"), nl,
        write("8. Toy + ball up to 500 rub."), nl,
        write("9. Most expensive toys"), nl,
        write("10. Toys for children 1-3 years under 300 rub."), nl,
        write("11. Toys for children 7-12 years"), nl,
        write("12. Average price of all toys"), nl,
        write("13. Two toys for different ages up to 800 rub."), nl, nl.

    processmenu(1):-
        addtoy, !.
    processmenu(2):-
        deletetoy, !.
    processmenu(3):-
        showall, !.
    processmenu(4):-
        writefile,
        write("Data saved."), nl,
        exit, !.
    processmenu(5):-
        query1, !.
    processmenu(6):-
        query2, !.
    processmenu(7):-
        query3, !.
    processmenu(8):-
        query4, !.
    processmenu(9):-
        query5, !.
    processmenu(10):-
        query6, !.
    processmenu(11):-
        query7, !.
    processmenu(12):-
        query8, !.
    processmenu(13):-
        query9, !.
    processmenu(_):-
        write("Invalid choice. Try again."), nl, !.
        
    addtoy:-
        nl, write("- Adding a toy"), nl,
        write("Enter toy name: "),
        getname(Name),
        write("Enter price: "),
        getprice(Price),
        write("Enter minimum age: "),
        getagemin(AgeMin),
        write("Enter maximum age: "),
        getagemax(AgeMax),
        assert(toy(Name, Price, AgeMin, AgeMax)),
        write("Toy added."), nl, nl.

    deletetoy:-
        nl, write("- Deleting a toy"), nl,
        write("Enter toy name to delete: "),
        getname(Name),
        retract(toy(Name, _, _, _)),
        write("Toy deleted."), nl, nl,
        !.
    deletetoy:-
        write("Toy with this name not found."), nl, nl.

    showall:-
        nl, write("- All toys: "), nl,
        toy(Name, Price, AgeMin, AgeMax),
        write(Name, " - ", Price, " rub. (", AgeMin, "-", AgeMax, " years)"), nl,
        fail.
    showall:-
        nl.

    query1:-
        nl, write("- Toys price <= 400 rub. for children 5 years: "), nl,
        toy(Name, Price, AgeMin, AgeMax),
        Price <= 400,
        AgeMin <= 5, AgeMax >= 5,
        write(Name, " - ", Price, " rub."), nl,
        fail.
    query1:- nl.

    query2:-
        nl, write("- Toys for children 4 and 10 years: "), nl,
        toy(Name, Price, AgeMin, AgeMax),
        AgeMin <= 4, AgeMax >= 4,
        AgeMin <= 10, AgeMax >= 10,
        write(Name, " - ", Price, " rub. (", AgeMin, "-", AgeMax, " years)"), nl,
        fail.
    query2:- nl.

    query3:-
        nl, write("- Prices of all cubes: "), nl,
        toy(Name, Price, _, _),
        Name = "cubes",
        write("Cubes: ", Price, " rub."), nl,
        fail.
    query3:- nl.

    query4:-
        nl, write("- Toy + ball up to 500 rub.: "), nl,
        toy(OtherToy, Price1, AgeMin1, AgeMax1),
        OtherToy <> "ball",
        AgeMin1 <= 3, AgeMax1 >= 3,
        toy("ball", Price2, AgeMin2, AgeMax2),
        AgeMin2 <= 3, AgeMax2 >= 3,
        Price1 + Price2 <= 500,
        Total = Price1 + Price2,
        write("Can buy: ", OtherToy, " (", Price1, " rub.) + ball (", Price2, " rub.)"), nl,
        write("Total cost: ", Total, " rub."), nl,
        fail.
    query4:-
    	!,
        write("End of options."), nl, nl.

    query5:-
        nl, write("- Most expensive toys (within 100 rub. of max price): "), nl,
        maxprice(MaxPrice),
        toy(Name, Price, _, _),
        MaxPrice - Price <= 100,
        write(Name, " - ", Price, " rub."), nl,
        fail.
    query5:- nl.

    query6:-
        nl, write("- Toys for children 1-3 years under 300 rub.: "), nl,
        toy(Name, Price, AgeMin, AgeMax),
        Price < 300,
        AgeMin <= 1, AgeMax >= 3,
        write(Name, " - ", Price, " rub. (", AgeMin, "-", AgeMax, " years)"), nl,
        fail.
    query6:- nl.

    query7:-
        nl, write("- Toys for children 7-12 years: "), nl,
        toy(Name, Price, AgeMin, AgeMax),
        AgeMin <= 7, AgeMax >= 12,
        write(Name, " - ", Price, " rub. (", AgeMin, "-", AgeMax, " years)"), nl,
        fail.
    query7:- nl.

    query8:-
        nl, write("- Average price of all toys: "),
        toy(_, P1, _, _),
        toy(_, P2, _, _),
        toy(_, P3, _, _),
        toy(_, P4, _, _),
        toy(_, P5, _, _),
        toy(_, P6, _, _),
        toy(_, P7, _, _),
        toy(_, P8, _, _),
        Sum = P1 + P2 + P3 + P4 + P5 + P6 + P7 + P8,
        Avg = Sum/8,
        write(Avg, " rub."), nl, nl,
        !.
    query8:- nl.

    query9:-
        nl, write("- Two toys for different ages up to 800 rub.: "), nl,
        toy(Toy1, Price1, AgeMin1, AgeMax1),
        toy(Toy2, Price2, AgeMin2, AgeMax2),
        Toy1 <> Toy2,
        AgeMax1 < AgeMin2, 
        Price1 + Price2 <= 800,
        Total = Price1 + Price2,
        write(Toy1, " (", Price1, " rub.) for ages ", AgeMin1, "-", AgeMax1), nl,
        write(Toy2, " (", Price2, " rub.) for ages ", AgeMin2, "-", AgeMax2), nl,
        write("Total: ", Total, " rub."), nl,
        fail.
    query9:-
        write("End of options."), nl, nl.

    getname(Name):-
        readln(Name).

    getprice(Price):-
        readint(Price).

    getagemin(AgeMin):-
        readint(AgeMin).

    getagemax(AgeMax):-
        readint(AgeMax).

    confirm('y'):- !.
    confirm('Y'):- !.
    confirm(_):- fail.

    maxprice(MaxPrice):-
        toy(_, MaxPrice, _, _),
        not(higherprice(MaxPrice)).

    higherprice(Price):-
        toy(_, HigherPrice, _, _),
        HigherPrice > Price.

    readfile:-
        existfile("toys.dba"),
        consult("toys.dba"),
        !.
    readfile:-
        assert(toy("doll", 450, 3, 10)),
        assert(toy("cubes", 350, 1, 5)),
        assert(toy("ball", 250, 2, 12)),
        assert(toy("radio car", 1200, 5, 12)),
        assert(toy("table hockey", 850, 7, 15)),
        assert(toy("puzzle", 300, 5, 12)),
        assert(toy("plush elephant", 400, 1, 8)),
        assert(toy("drawing set", 550, 4, 10)),
        assert(toy("constructor", 750, 5, 14)),
        assert(toy("pyramid", 200, 1, 4)),
        assert(toy("robot", 890, 7, 15)),
        assert(toy("teddy bear", 420, 2, 6)).

    writefile:-
        save("toys.dba"), nl.