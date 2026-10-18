DOMAINS
    file = input_file; output_file
    wordlist = string*

PREDICATES
    nondeterm process
    justify_string(string, integer, string)
    split_string(string, wordlist)
    count_chars(wordlist, integer)
    distribute_spaces(wordlist, integer, wordlist)
    assemble_string(wordlist, string)
    add_spaces_to_end(string, integer, string)
    make_space_block(integer, string)
    length_of_list(wordlist, integer)
    distribute_evenly(wordlist, integer, integer, integer, wordlist)
    nondeterm read_and_process(integer)

CLAUSES

    process :-
        write("Введите требуемую длину строки: "),
        readint(MaxLen),
        openread(input_file, "input.txt"),
        readdevice(input_file),
        openwrite(output_file, "output.txt"),
        writedevice(output_file),
        read_and_process(MaxLen),
        writedevice(screen),
        closefile(input_file),
        closefile(output_file),
        write("Выровненные строки в output.txt"), nl.

    read_and_process(MaxLen) :-
        readln(Line),
        justify_string(Line, MaxLen, ResLine),
        write(ResLine), nl,
        not(Line = ""),
        read_and_process(MaxLen).

    read_and_process(_).

    % Neskolko slov
    justify_string(Line, MaxLen, ResLine) :-
        split_string(Line, Words),
        Words = [_, _ | _], !,
        count_chars(Words, TotalChars),
        TotalSpaces = MaxLen - TotalChars,
        distribute_spaces(Words, TotalSpaces, SpacedWords),
        assemble_string(SpacedWords, ResLine).
        
    % Odno slovo ili pustaya stroka
    justify_string(Line, MaxLen, ResLine) :-
        str_len(Line, Len),
        Spaces = MaxLen - Len,
        add_spaces_to_end(Line, Spaces, ResLine).

    % Dobavlenie probelov v konec stroki
    add_spaces_to_end(Line, 0, Line) :- !.
    add_spaces_to_end(Line, N, ResLine) :-
        N > 0,
        concat(Line, " ", Tmp),
        N1 = N - 1,
        add_spaces_to_end(Tmp, N1, ResLine).

    % Razbienie stroki na spisok slov
    split_string("", []) :- !.
    split_string(Str, [Token | RestTokens]) :-
        fronttoken(Str, Token, Rest),
        Token <> "", !,
        split_string(Rest, RestTokens).
    split_string(_, []) :- !.

    % Podschet summy dlin vseh slov v spiske
    count_chars([], 0).
    count_chars([H | T], Total) :-
        str_len(H, Len),
        count_chars(T, Rest),
        Total = Len + Rest.

    % Ravnomernoe raspredelenie probelov mezhdu slovami
    distribute_spaces(Words, TotalSpaces, SpacedWords) :-
        length_of_list(Words, WordCount),
        GapsCount = WordCount - 1,
        BaseSpaces = TotalSpaces div GapsCount,
        ExtraSpaces = TotalSpaces mod GapsCount,
        distribute_evenly(Words, GapsCount, BaseSpaces, ExtraSpaces, SpacedWords).
 
    % Podschet dliny spiska
    length_of_list([], 0).
    length_of_list([_ | T], N) :-
        length_of_list(T, N1),
        N = N1 + 1.

    % Sozdanie bloka iz N probelov
    make_space_block(0, "") :- !.
    make_space_block(N, Block) :-
        N > 0,
        N1 = N - 1,
        make_space_block(N1, Tmp),
        concat(" ", Tmp, Block).

    % Ostalos odno slovo - vyhod
    distribute_evenly([W], _, _, _, [W]) :- !.

    % Est dopolnitelnye probely
    distribute_evenly([W1, W2 | Rest], GapsLeft, Base, Extra, [W1, Block | Padded]) :-
        Extra > 0, !,
        SpaceCount = Base + 1,
        make_space_block(SpaceCount, Block),
        Extra1 = Extra - 1,
        distribute_evenly([W2 | Rest], GapsLeft, Base, Extra1, Padded).
 
    % Dop probely zakonchilis, dobavlyaem bazovoe kolichestvo
    distribute_evenly([W1, W2 | Rest], GapsLeft, Base, 0, [W1, Block | Padded]) :-
        make_space_block(Base, Block),
        distribute_evenly([W2 | Rest], GapsLeft, Base, 0, Padded).

    % Sborka spiska strok v odny stroky
    assemble_string([], "").
    assemble_string([H | T], Res) :-
        assemble_string(T, Tmp),
        concat(H, Tmp, Res).

GOAL
    process.