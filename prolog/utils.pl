next_vertices(Class, Name, L) :-
    findall([Class, Name, Relation, OtherClass, OtherName], 
	    row(Class, Name, Relation, OtherClass, OtherName), L).

prev_vertices(Class, Name, L) :-
    findall([OtherClass, OtherName, Relation, Class, Name], 
	    row(OtherClass, OtherName, Relation, Class, Name), L).

get_data_by_relation(Relation, L) :-
    findall([Class, Name, Relation, OtherClass, OtherName], 
	    row(Class, Name, Relation, OtherClass, OtherName), L).

get_data_by_name(Name, L) :-
    next_vertices(_Class1, Name, L1),
    prev_vertices(_Class2, Name, L2),
    append([L1,L2], LL),
    list_to_set(LL, L).
