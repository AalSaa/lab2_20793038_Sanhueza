:- module(tda_option_20793038_SanhuezaVega, [option/6]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
% M. Primaria: option/6
% M. Secundaria: downcase_atom/2, stringDownInList/2.
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    downcase_atom(Message, MinMessage),
    stringDownInList(Keyword, MinKeyword),
    Option = [ID, MinMessage, ChatbotCodeLink, FlowCodeLink, MinKeyword].