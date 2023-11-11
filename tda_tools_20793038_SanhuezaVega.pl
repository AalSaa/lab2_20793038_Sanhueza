:- module(tda_tools, [idExists/2, stringDownInList/3, addElementsInList/3, getElementByID/3]).

% ######################################## PERTENENCIA #######################################
% Descripcion: Verifica si existe un elemento con la id indicada en una lista de elementos.
% Dom: ID (int) X ElementList (list)
idExists(ID, [First | _]):-
    getID(First, IDE),
    ID == IDE, !.

idExists(ID, [_ | Rest]):-
    idExists(ID, Rest).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un elemento.
% Dom: Elemento, ID.
getID([ID | _], ID).

% Descripcion: Obtiene un elemento segun su id.
% Dom: ID (int) X ElementList (list) X SelectedElement(var)
getElementByID(ID, [First | _], SelectedElement):-
    getID(First, IDE),
    ID == IDE,
    SelectedElement = First, !.

getElementByID(ID, [_ | Rest], SelectedElement):-
    getElementByID(ID, Rest, SelectedElement).

% ######################################## MODIFICADOR #######################################

% Descripcion: Auxiliar de stringDownInList/2, cambia cada string de la lista a minusculas.
% Dom: OriginalList (list) X NewList (list) X FinalList (var)
stringDownInList([], NewList, FinalList):-
    FinalList = NewList, !.

stringDownInList([First | Rest], NewList, FinalList):-
    downcase_atom(First, NewFirst),
    append(NewList, [NewFirst], NewUpdatedList),
    stringDownInList(Rest, NewUpdatedList, FinalList).

% Descripcion: Agrega elementos a una lista sin que se repita el id en alguno de ellos.
% Dom: NewElements (list) X ElementList (list) X FinalElementList (var)
addElementsInList([], ElementList, FinalElementList):-
    FinalElementList = ElementList, !.

addElementsInList([First | Rest], ElementList, FinalElementList):-
    getID(First, ID),
    \+ idExists(ID, ElementList),
    append(ElementList, [First], NewElementList),
    addElementsInList(Rest, NewElementList, FinalElementList), !.