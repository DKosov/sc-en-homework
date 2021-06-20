:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_parameters)).
:- use_module(library(uri)). 

:- use_module(library(http/json)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json_convert)).

:- http_handler('/get-data-by-relation', data_by_relation, []).
:- http_handler('/get-data-by-name', data_by_name, []).

:- consult('utils').

server(Port) :-
    csv_read_file("data.csv", Rows, [functor(row), arity(5)]),
    maplist(assert, Rows),
    http_server(http_dispatch, [port(Port)]).

rows_to_term_json([C1, R1, Rel, C2, R2], json([from=json([class=C1,name=R1]), to=json([class=C2,name=R2]), rel=Rel])).

data_by_name(Request) :-
    http_parameters(Request,
		    [
		     name(NameString,   [])
		    ]),
    read_term_from_atom(NameString, Name, []),
    get_data_by_name(Name, Rows),
    maplist(rows_to_term_json, Rows, PE),
    prolog_to_json(json([rows=PE]), Json),
    reply_json(Json).

data_by_relation(Request) :-
    http_parameters(Request,
		    [
		     relation(NameString,   [])
		    ]),
    read_term_from_atom(NameString, Relation, []),
    get_data_by_relation(Relation, Rows),
    maplist(rows_to_term_json, Rows, PE),
    prolog_to_json(json([raws=PE]), Json),
    reply_json(Json).


