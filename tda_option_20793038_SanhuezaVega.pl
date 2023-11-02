% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
% M. Primaria: option/6
% M. Secundaria: -
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    downcase_atom(Message, MinMessage),
    stringDownInList(Keyword, MinKeyword),
    Option = [ID, MinMessage, ChatbotCodeLink, FlowCodeLink, MinKeyword].

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