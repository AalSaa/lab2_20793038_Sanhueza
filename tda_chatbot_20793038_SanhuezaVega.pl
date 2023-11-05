:- module(tda_chatbot_20793038_SanhuezaVega, [setChatbot/6, getChatbotID/2, getChatbotName/2, getChatbotWelcomeMessage/2, getChatbotStartFlowID/2, getChatbotFlowList/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un flujo.
% Dom: ID (int) X name (string) X WelcomeMessage (string) X 
%      StartFlowID (int) X FlowList (list) X Chatbot (var)
% M. Primaria: setChatbot/6
% M. Secundaria: -
setChatbot(ID, Name, WelcomeMessage, StartFlowID, FlowList, Chatbot):-
    Chatbot = [ID, Name, WelcomeMessage, StartFlowID, FlowList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un chatbot.
% Dom: Chatbot (list) X ChatbotID (var)
% M. Primaria: getChatbotID/2
% M. Secundaria: setChatbot/6
getChatbotID(Chatbot, ChatbotID):-
    setChatbot(ChatbotID, _, _, _, _, Chatbot).

% Descripcion: Obtiene el nombre del chatbot.
% Dom: Chatbot (list) X ChatbotName(var)
% M. Primaria: getChatbotName/2
% M. Secundaria: setChatbot/6
getChatbotName(Chatbot, ChatbotName):-
    setChatbot(_, ChatbotName, _, _, _, Chatbot).

% Descripcion: Obtiene el mensaje de bienvenida de un chatbot.
% Dom: Chatbot (list) X ChatbotWelcomeMessage (var)
% M. Primaria: getChatbotWelcomeMessage/2
% M. Secundaria: setChatbot/6
getChatbotWelcomeMessage(Chatbot, ChatbotWelcomeMessage):-
    setChatbot(_, _, ChatbotWelcomeMessage, _, _, Chatbot).

% Descripcion: Obtiene el id del flujo inicial de un chatbot.
% Dom: Chatbot (list) X ChatbotStartFlowID (var)
% M. Primaria: getChatbotStartFlowID/2
% M. Secundaria: setChatbot/6
getChatbotStartFlowID(Chatbot, ChatbotStartFlowID):-
    setChatbot(_, _, _, ChatbotStartFlowID, _, Chatbot).

% Descripcion: Obtiene la lista de flujos de un chatbot.
% Dom: Chatbot (list) X ChatbotFlowList (var)
% M. Primaria: getChatbotFlowList/2
% M. Secundaria: setChatbot/6
getChatbotFlowList(Chatbot, ChatbotFlowList):-
    setChatbot(_, _, _, _, ChatbotFlowList, Chatbot).