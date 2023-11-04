:- module(tda_tools_20793038_SanhuezaVega, [stringDownInList/2, addElementsInList/3]).

% ######################################## PERTENENCIA #######################################
% Descripcion: Verifica si existe un elemento con la id indicada en una lista de elementos.
% Dom: ID (int) X ElementList (list)
% M. Primaria: idExists/2
% M. Secundaria: getID/2
idExists(_, []):-
    fail, !.

idExists(ID, [First | _]):-
    getID(First, IDE),
    ID == IDE, !.

idExists(ID, [_ | Rest]):-
    idExists(ID, Rest).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un elemento.
% Dom: Elemento, ID.
% M. Primaria: getID/2
% M. Secundaria: -
getID([ID | _], ID).

% ######################################## MODIFICADOR #######################################

% Descripcion: Convierte todos los strings de una lista en minusculas.
% Dom: OriginalList (list) X FinalList (var)
% M. Primaria: stringDownInList/2
% M. Secundaria: stringDownInList/3
stringDownInList(OriginalList, FinalList):-
    stringDownInList(OriginalList, [], FinalList).

% Descripcion: Auxiliar de stringDownInList/2, cambia cada string de la lista a minusculas.
% Dom: OriginalList (list) X NewList (list) X FinalList (var)
% M. Primaria: stringDownInList/3
% M. Secundaria: downcase_atom/2, append/3
stringDownInList([], NewList, FinalList):-
    FinalList = NewList, !.

stringDownInList([First | Rest], NewList, FinalList):-
    downcase_atom(First, NewFirst),
    append(NewList, [NewFirst], NewUpdatedList),
    stringDownInList(Rest, NewUpdatedList, FinalList).

% Descripcion: Agrega elementos a una lista sin que se repita el id en alguno de ellos.
% Dom: NewElements (list) X ElementList (list) X FinalElementList (var)
% M. Primaria: addElementsInList/3
% M. Secundaria: getID/2, idExists/2, append/3
addElementsInList([], ElementList, FinalElementList):-
    FinalElementList = ElementList, !.

addElementsInList([First | Rest], ElementList, FinalElementList):-
    getID(First, ID),
    \+ idExists(ID, ElementList),
    append(ElementList, [First], NewElementList),
    addElementsInList(Rest, NewElementList, FinalElementList), !.

addElementsInList([_ | Rest], ElementList, FinalElementList):-
    addElementsInList(Rest, ElementList, FinalElementList).