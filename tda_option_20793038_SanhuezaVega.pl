% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
% M. Primaria: option/6
% M. Secundaria: -
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    Option = [ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword].