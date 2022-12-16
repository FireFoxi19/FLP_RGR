:- discontiguous func/1.
:- dynamic toy/3.

task3:-
 retractall(toy(_,_,_)),
 exists_file('DataBase.txt'),!,
 consult('DataBase.txt'),
 menu.

task3:-
 tell('DataBase.txt'),
 told,
 menu.

menu:-
 repeat,
 nl,
 writeln('1) - �������� ����������� ���� ������;'),
 writeln('2) - ���������� ������'),
 writeln('3) - �������� ������'),
 writeln('4) - ����� ������� ������� �� 3 ���'),
 writeln('5) - ����� � ���������� ���� ������'),
 read(X),
 X>0,
 X<6,
 func(X),
 X=:=5,!.

func(1):-
 listing(toy/3).

func(2):-
 repeat,
 writeln("������� �������� �������:"),
 read(N),
 writeln("������� ���������:"),
 read(Pr),
 writeln("������� ���������� �����������:"),
 read(A),
 assertz(toy(N,Pr,A)),
 writeln("�� ������ ���������� ���������� [y/n]?"),
 read(Sw),
 Sw=n,!.

func(3):-
 repeat,
 writeln("������� �������� �������:"),
 read(N),
 retract(toy(N,_,_)),
 writeln("�� ������ ���������� �������� [y/n]?"),
 read(Sw),
 Sw=n,!.

func(4):-
 find_toys(L_Res),
 write_list(L_Res).

find_toys(L_Res):-
 findall(toy(N,Pr,A),(toy(N,Pr,A),A=<3),L),
 min_toys(L,_,L_Res).

min_toys([],_,[]):-
 writeln("������� �� �������").

min_toys([H],Min,L_Res):-
 H=toy(_,Min,_),!,
 L_Res=[H].
 
min_toys([H|T],Min,L_Res):-
 H=toy(_,Min1,_),
 min_toys(T,Min2,L_Res2),
 check_min(H,Min1,L_Res2,Min2,L_Res,Min).

check_min(H,Min1,_,Min2,L_Res,Min):-
 Min1<Min2,!,
 Min=Min1,
 L_Res=[H].
 
check_min(H,Min1,L_Res2,Min2,L_Res,Min):-
 Min1=:=Min2,!,
 Min=Min1,
 L_Res=[H|L_Res2].
 
check_min(_,_,L_Res2,Min2,L_Res,Min):-
 Min=Min2,
 L_Res=L_Res2.

write_list([]):-!.

write_list([H|T]):-
 writeln(H),
 write_list(T).

func(5):-
 tell('DataBase.txt'),
 listing(toy/3),
 told.
