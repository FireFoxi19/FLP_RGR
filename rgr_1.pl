odd_even([], [], []).
odd_even([Head | Tail], [Head | Even], Odd):-
Head mod 2 =:= 0, !, odd_even(Tail, Even, Odd).
odd_even([Head | Tail], Even, [Head | Odd]):-
Head mod 2 =:= 1, !, odd_even(Tail, Even, Odd).

odd_even_sort(List):-
odd_even(List, Even, Odd),
write('Четные: '), write(Even), nl,
write('Нечетные: '), write(Odd), nl.
