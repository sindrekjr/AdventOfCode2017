readFile(Path, Lines) :- open(Path, read, File), read_string(File, _, Str), split_string(Str, "\n", "\n", Lines).

main(R) :-
  readFile("input", Input),
  maplist(group, Input, Groups),
  /*flatten(Groups, Programs),
  connected(Programs, Groups, [0], Relations),*/
  connected([0], [], Groups, Relations),
  sort(Relations, Uniques),
  length(Uniques, R).

/*connected([], _, R, R).
connected([H|T], Groups, X, R) :-
  member(H, X) -> connected(Groups, H, X1), connected(T, Groups, X1, R) ; connected(T, Groups, X, R).

connected([], R, R).
connected([H|T], X, R) :-
  member(Y, H), member(Y, X) -> flatten([H|X], X1), connected(T, X1, R) ; connected(T, X, R).*/
connected([], _, _, []).
connected([P|Tail], Visited, Groups, [P|R]):-
  select([P|Ps], Groups, NGroups),
  subtract(Ps, [P|Visited], NPs),
  union(Tail, NPs, NTail),
  connected(NTail, [P|Visited], NGroups, R).

group(Line, Result) :-
  split_string(Line, "<->", " <-> ", [ A, B ]),
  split_string(B, ", ", ", ", Bs),
  maplist(toInt, Bs, BsInt),
  toInt(A, AInt),
  Result = [ AInt | BsInt ].

toInt(String, Int) :- atom_codes(String, Code), number_codes(Int, Code).
