:- module(tda_tools, [idExists/2, getElementByID/3, stringDownInList/3, addElementsInList/3]).

% ######################################## TDA TOOLS #########################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a las herramientas.
% Se utilizara casos similares dentro de los demas TDA.

% ######################################## PERTENENCIA #######################################
% Descripcion: Verifica si existe un elemento con la id indicada en una lista de elementos.
% Dom: ID (int) X ElementList (list)
% Rec: -
% Metodo: Recursion
idExists(ID, [First | _]):-
    getID(First, IDE),
    ID == IDE, !.

idExists(ID, [_ | Rest]):-
    idExists(ID, Rest).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un elemento.
% Dom: Elemento (list)
% Rec: ID (int)
% Metodo: -
getID([ID | _], ID).

% Descripcion: Obtiene un elemento segun su id.
% Dom: ID (int) X ElementList (list) 
% Rec: SelectedElement(list)
% Metodo: Recursion
getElementByID(ID, [First | _], SelectedElement):-
    getID(First, IDE),
    ID == IDE,
    SelectedElement = First, !.

getElementByID(ID, [_ | Rest], SelectedElement):-
    getElementByID(ID, Rest, SelectedElement).

% ######################################## MODIFICADOR #######################################

% Descripcion: Auxiliar de stringDownInList/2, cambia cada string de la lista a minusculas.
% Dom: OriginalList (list) X NewList (list)
% Rec: FinalList (list)
% Metodo: Recursion
stringDownInList([], NewList, FinalList):-
    FinalList = NewList, !.

stringDownInList([First | Rest], NewList, FinalList):-
    downcase_atom(First, NewFirst),
    append(NewList, [NewFirst], NewUpdatedList),
    stringDownInList(Rest, NewUpdatedList, FinalList).

% Descripcion: Agrega elementos a una lista sin que se repita el id en alguno de ellos.
% Dom: NewElements (list) X ElementList (list)
% Rec: FinalElementList (list)
% Metodo: Recursion
addElementsInList([], ElementList, FinalElementList):-
    FinalElementList = ElementList, !.

addElementsInList([First | Rest], ElementList, FinalElementList):-
    getID(First, ID),
    \+ idExists(ID, ElementList),
    append(ElementList, [First], NewElementList),
    addElementsInList(Rest, NewElementList, FinalElementList).