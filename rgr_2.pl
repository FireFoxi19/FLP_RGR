str_to_list_words(S, [Hw | Tn]):-
    front_token(S, W, S2), not(S2 = " "), !,
    Hw = W, str_to_list_words(S2, Tn).
    str_to_list_words(_, []).

%ѕредикат, который выдел€ет слова из строки.
front_token(S, W, L1):-
    atom_chars(S, L), %строка > список символов
    append(ListW, [' ' | List1], L), !,
    atom_chars(W, ListW),
    atom_chars(L1, List1).
    
front_token(S, W, L1):-
    atom_chars(S, L), %строка > список символов
    append(ListW, ['.' | List1], L), !,
    atom_chars(W, ListW),
    atom_chars(L1, List1).

%ѕредикат формировани€ списка длин слов по списку этих слов
arr_len_word([], []):- !.
arr_len_word([H | T], [Hn | Tn]):-
    atom_length(H, LenW),
    Hn = LenW,
    arr_len_word(T, Tn).

%ѕредикат нахождени€ максимума в списке (длин заданных слов)
maximum([X], X).
maximum([H | T], H):-maximum(T, M), H > M, !.
maximum([_ | T], M):-maximum(T, M).

%ѕредикат формировани€ нового списка путем удалени€ из заданного списка слов длины, отличной от заданной величины
list_of_max_words([], _, []):- !.
list_of_max_words([H | T], X, [Hn | Tn]):-
    atom_length(H, LenW), %длина строки
    LenW = X, !,
    Hn = H,
    list_of_max_words(T, X, Tn).
list_of_max_words([_ | T], X, Ln):- list_of_max_words(T, X, Ln).

%ѕредикат дл€ чтени€ строки в файл
read_from_file(Filename, S):-
    open(Filename, read, Input),
    readln(Input, S),
    close(Input).

%ѕредикат дл€ записи строки в файл
write_to_file(Filename, S):-
    open(Filename, write, Out),
    write(Out, S),
    close(Out).
    
max_len_words(S, Sn):-
    write("—писок слов:"), nl,
    str_to_list_words(S, Lw), %формирование списка Lw из слов строки S
    write(Lw), nl,
    arr_len_word(Lw, Ll), %нахождение длин слов и занесение их в список
    maximum(Ll, MaxLen), %нахождение максимальной из длин слов
    write("ƒлина наиболее длинного слова: "), write(MaxLen), nl,
    list_of_max_words(Lw, MaxLen, Ln), %формировани€ списка слов макс.длины
    atomics_to_string(Ln, " ", Sn), %список > строка
    write(Sn).
    
t2:-
    see('input.txt'),
    seeing(Stream),
    read_stream_to_codes(Stream, List_of_codes),
    string_to_list(String, List_of_codes),
    max_len_words(String, FinalListMaxWords),
    seen,
    tell('output.txt'),
    write(FinalListMaxWords),
    told.
    

