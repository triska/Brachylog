/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
____            ____
\   \          /   /
 \   \  ____  /   /
  \   \/    \/   /
   \     /\     /     BRACHYLOG       
    \   /  \   /      A terse declarative logic programming language
    /   \  /   \    
   /     \/     \     Written by Julien Cumin - 2016
  /   /\____/\   \    https://github.com/JCumin/Brachylog
 /   /  ___   \   \
/___/  /__/    \___\
     
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */


:- module(string_predicates, [brachylog_string_blocks/2,
                              brachylog_string_lowercase/2,
                              brachylog_string_uppercase/2,
                              brachylog_string_dichotomize/2,
                              brachylog_string_trichotomize/2,
                              brachylog_string_tetrachotomize/2,
                              brachylog_string_pentachotomize/2,
                              brachylog_string_hexachotomize/2,
                              brachylog_string_heptachotomize/2,
                              brachylog_string_octachotomize/2,
                              brachylog_string_enneachotomize/2
                             ]).
                       
:- use_module(library(clpfd)).
:- use_module(utils).
 
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   BRACHYLOG_STRING_BLOCKS
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
brachylog_string_blocks([],[]).
brachylog_string_blocks([H|T],Blocks) :-
    brachylog_string_blocks([H|T],H,Blocks).

brachylog_string_blocks([],_,[[]]).
brachylog_string_blocks([H|T],H,[[H|T2]|T3]) :-
    brachylog_string_blocks(T,H,[T2|T3]).
brachylog_string_blocks([H|T],I,[[],[H|T2]|T3]) :-
    dif(H,I),
    brachylog_string_blocks(T,H,[T2|T3]).


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   BRACHYLOG_STRING_LOWERCASE
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
brachylog_string_lowercase('string':Ls0,'string':Ls) :-
    maplist(downcase_atom, Ls0, Ls).


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   BRACHYLOG_STRING_UPPERCASE
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
brachylog_string_uppercase('string':Ls0,'string':Ls) :-
    maplist(upcase_atom, Ls0, Ls).

    
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
   BRACHYLOG_STRING_NCHOTOMIZE
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
brachylog_string_dichotomize(X,[A,B]) :-
    brachylog_string_Nchotomize(X,[A,B]).

brachylog_string_trichotomize(X,[A,B,C]) :-
    brachylog_string_Nchotomize(X,[A,B,C]).

brachylog_string_tetrachotomize(X,[A,B,C,D]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D]).

brachylog_string_pentachotomize(X,[A,B,C,D,E]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D,E]).

brachylog_string_hexachotomize(X,[A,B,C,D,E,F]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D,E,F]).

brachylog_string_heptachotomize(X,[A,B,C,D,E,F,G]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D,E,F,G]).

brachylog_string_octachotomize(X,[A,B,C,D,E,F,G,H]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D,E,F,G,H]).

brachylog_string_enneachotomize(X,[A,B,C,D,E,F,G,H,I]) :-
    brachylog_string_Nchotomize(X,[A,B,C,D,E,F,G,H,I]).
    
brachylog_string_Nchotomize('string':L,L2) :-
    (
        var(L)
        -> maplist(prepend_string,M,L2),
        brachylog_string_Nchotomize(L,M)
        ;
        length(L2,Length),
        length(M,Length),
        brachylog_string_Nchotomize(L,M),
        maplist(prepend_string,M,L2)
    ). 
brachylog_string_Nchotomize(L,L2) :-
    append(L2,L),
    length(L,LengthL),
    length(L2,LengthL2),
    Length #= LengthL//LengthL2,
    reverse(L2,[_|T]),
    maplist(length_(Length),T).
