%%
%
%   Progetto Mastermind
%
%   Estevao Luis Costa Moura de Luna
%   matricola 774158
%
%
%
%%


% L'obiettivo del gioco è indovinare la corretta sequenza di 4 colori.
% Questi colori sono distinti per posizione e possono essere ripetuti.
% Ad ogni tentativo dell'utente il programma dirà quanti colori si
% trovano nella giusta posizione e quanti sono presenti nella sequenza
% corretta, ma si trovano nella posizione sbagliata.
% Il giocatore vince quando ha indovinato la sequenza obiettivo.



% Colori usati nel gioco
colore(rosso).
colore(giallo).
colore(verde).
colore(blu).
colore(bianco).
colore(nero).

% Sequenza da indovinare
sequenza_obiettivo([blu, rosso, rosso, giallo]).


% META PRINCIPALE
% Meta per iniziare a giocare
gioca:-
	writeln('L''obiettivo del gioco è indovinare la corretta sequenza di 4 colori'),
	writeln('I colori presenti sono: rosso, giallo, verde, blu, bianco e nero'),
	writeln('I colori si distinguono per posizione e possono essere ripetuti'),
	writeln('Per fare un tentativo scrivi il nome del colore nel seguente formato: colore.'),
	writeln('e premi INVIO. Inserisci 4 colori e osserva i risultati'),
	writeln('Buona partita!'),
	input.


% INPUT DEI 4 COLORI
% Predicato senza accumulatore
input:-
	input(4, []).
% Caso base, i 4 colori sono già stati caricati,
% ora si verifica se la sequenza inserita dall'utente
% è uguale alla sequenza da indovinare
input(0, L):-
	!,
	sequenza_obiettivo(S),
	verifica(L,S).
% Caso ricorsivo: ancora colori da caricare
input(K, L):-
	read(C),
	colore(C),
	conc(L,[C],L1),
	K1 is K-1,
	input(K1, L1).


% VERIFICA
% T è la sequenza dell'utente che deve essere
% confrontata con S che è la sequenza da indovinare
%
% Se sono uguali, il gioco finisce e il giocatore
% ha vinto
verifica(T,S):-
	uguali(T,S),
	write('Complimenti! Hai indovinato!'),
	!.
% Se sono diverse,
% si contano i colori nella posizione corretta
% e i colori che sono presenti nella sequenza
% obiettivo.
% All'utente verrà comunicato il numero dei
% colori nella corretta posizione e quelli che
% sono presenti, ma non sono nella posizione
% corretta. Infine verrà chiesto all'utente di inserire
% una nuova sequenza
verifica(T,S):-
	posizione_giusta(T,S,N1),
	presenza(T,S,N2),
	risultati(N1,N2),
	input.





% OPERAZIONI SULLE LISTE
% Concatenazione
conc([],L,L).
conc([X|L1],L2,[X|L3]):-
	conc(L1,L2,L3).
% Cancellazione
del(X,[X|L],L).
del(X,[Y|L1],[Y|L2]):-
	del(X,L1,L2).

% Verifico se due liste sono uguali
uguali(L,L).






% REGOLE PER DETERMINARE QUANTI COLORI SONO NELLA GIUSTA POSIZIONE
% posizione_giusta(T,S,N)
% T è la sequenza tentativo dell'utente
% S è la sequenza da indovinare
% N è il numero di colori nella giusta posizione

% Scorrerò le due liste per vedere quanti colori sono uguali,
% per questo mi servirà un accumulatore che partirà da 0
posizione_giusta(T,S,N):-
	posizione_giusta(T,S,N,0).
% Caso base,
% in cui abbiamo finito di scorrere le liste
% N sarà il numero di colori nella giusta posizione
posizione_giusta([],[],N,N):-
	!.
% Caso in cui gli elementi in testa coincidono
% e il contatore viene incrementato
posizione_giusta([X|T],[X|S],N,ACC):-
	!,
	ACC1 is ACC+1,
	posizione_giusta(T,S,N,ACC1).
% Caso in cui gli elementi in testa sono diversi
posizione_giusta([X|T],[Y|S],N,ACC):-
	posizione_giusta(T,S,N,ACC).





% REGOLE PER DETERMINARE QUANTI COLORI SONO PRESENTI
% NELLA SEQUENZA OBIETTIVO
% presenza(T,S,N)
% T è la sequenza tentativo dell'utente
% S è la sequenza da indovinare
% N è il numero di colori presenti anche nella sequenza obiettivo

% Considero un elemento alla volta di T e vedo se questo è presente in S

% Mi servirà usare anche una copia della lista S, in modo da
% ripristinare la lista ogni volta che ho finito di scorrerla per
% cercare un colore di T.
% Mi servirà anche un accumulatore per contare le presenze
presenza(T,S,N):-
	presenza(T,S,S,N,0).

% Caso base, in cui abbiamo finito di scorrere T.
presenza([],S,S1,N,N):-
	!.

% Caso in cui un elemento di T è presente anche in S.
% Il contatore verrà incrementato e l'elemento sarà cancellato da S per
% evitare di essere ricontato erroneamente nel caso in cui l'elemento
% sia presente ancora in T.
presenza([X|T],S,[X|S1],N,ACC):-
	!,
	del(X,S,S2),
	ACC1 is ACC+1,
	presenza(T,S2,S2,N,ACC1).
% Caso in cui gli elementi confrontati sono diversi
% Considero l'elemento successivo di S
presenza([X|T],S,[Y|S1],N,ACC):-
	presenza([X|T],S,S1,N,ACC).
% Caso in cui ho finito di scorrere S
% Considero il successivo elemento di T
presenza([X|T],S,[],N,ACC):-
	presenza(T,S,S,N,ACC).


% Stampa dei risultati:
% Numero dei colori nella giusta posizione
% e numero dei colori fuori posizione
risultati(Pos_corrette, Presenze):-
	write('Posizioni corrette: '),
	writeln(Pos_corrette),
	write('Fuori posizione: '),
	Fuori_posizione is Presenze - Pos_corrette,
	writeln(Fuori_posizione),
	nl,
	writeln('Prova ancora: ').






































































