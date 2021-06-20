Prolog
==========

HTTP server prolog

# Usage

Install SWI Prolog and run the server

	apt-get install swi-prolog
	swipl webserver.pl --port=8080

Run:

	curl "http://lvh.me:8080/get-data-by-name?name=denis"
or

	curl "http://lvh.me:8080/get-data-by-relation?relation=love"
