:- module(tda_option_20793038_SanhuezaVega, [setOption/6, getOptionMessage/2, getOptionCBCodelink/2, getOptionFCodelink/2, getOptionByMessage/3]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (int) X FlowCodeLink (int) X 
%      Keyword (list) X Option (var)
setOption(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    Option = [ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el ID de una opcion.
% Dom: Option (list) X OptionID (var)
getOptionID(Option, OptionID):-
    setOption(OptionID, _, _, _, _, Option).

% Descripcion: Obtiene el mensaje de una opcion.
% Dom: Option (list) X OptionMessage (var)
getOptionMessage(Option, OptionMessage):-
    setOption(_, OptionMessage, _, _, _, Option).

% Descripcion: Obtiene el Chatbot codelink de una opcion.
% Dom: Option (list) X OptionCBCodelink (var)
getOptionCBCodelink(Option, OptionCBCodelink):-
    setOption(_, _, OptionCBCodelink, _, _, Option).

% Descripcion: Obtiene el Flow codelink de una opcion.
% Dom: Option (list) X OptionFCodelink (var)
getOptionFCodelink(Option, OptionFCodelink):-
    setOption(_, _, _, OptionFCodelink, _, Option).

% Descripcion: Obtiene la lista de palabras claves de una opcion.
% Dom: Option (list) X OptionKeyword (var)
getOptionKeyword(Option, OptionKeyword):-
    setOption(_, _, _, _, OptionKeyword, Option).

% Descripcion: Obtiene una opcion segun su mensaje o id.
% Dom: Message (string) X OptionList (list) X SelectedOption (var) 
getOptionByMessage(Message, [First | _], SelectedOption):-
    getOptionID(First, OptionID),
    number_string(OptionID, SOptionID),
    SOptionID == Message,
    SelectedOption = First, !.

getOptionByMessage(Message, [First | _], SelectedOption):-
    downcase_atom(Message, MinMessage),
    getOptionKeyword(First, OptionKeyword),
    member(MinMessage, OptionKeyword),
    SelectedOption = First, !.

getOptionByMessage(Message, [_ | Rest], SelectedOption):-
    getOptionByMessage(Message, Rest, SelectedOption).