:- module(tda_option_20793038_SanhuezaVega, [setOption/6]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
% M. Primaria: setOption/6
% M. Secundaria: -
setOption(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    Option = [ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword].