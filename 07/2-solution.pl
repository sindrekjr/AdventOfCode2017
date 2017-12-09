main(R) :- readFile("input", R).%, root(R, Sltn).

root(All, Root) :- subPrograms(All, Subs), not(member(Root, Subs)), member(node(Root, _, _), All).

subProgram(node(_, _, Sub), Sub).
subPrograms(All, Subs) :- maplist(subProgram, All, Sublist), flatten(Sublist, Subs).

readFile(Path, Res) :- open(Path, read, File), read_string(File, _, Str), splitNodesByLine(Str, Res).
splitNodesByLine(String, Res) :- split_string(String, "\n", "\n", Lines), maplist(line, Lines, Res), !.
line(L, node(Name, Weight, Sub)) :-
  split_string(L, "(", "(", [Prog, Rest]),
  split_string(Rest, ")", ")", [NA|Subs]),
  string_to_list(Prog, Proglist),
  select(32, Proglist, NmL),
  string_to_list(Name, NmL),
  number_codes(Weight, NA),
  (
    Subs = [] -> Sub = nil;
    Subs = [SubsH|_],
    string_to_list(SubsH, [_, _, _, _|P]),
    string_to_list(P2, P),
    split_string(P2, ", ", ", ", Sub)
  ).
