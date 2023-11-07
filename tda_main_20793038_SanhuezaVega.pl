:- module(tda_main_20793038_SanhuezaVega, [option/6, flow/4, flowAddOption/3, chatbot/6, chatbotAddFlow/3, system/4]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_date_20793038_SanhuezaVega).
:- use_module(tda_system_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
% M. Primaria: option/6
% M. Secundaria: downcase_atom/2, stringDownInList/2, setOption/6.
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    downcase_atom(Message, MinMessage),
    stringDownInList(Keyword, MinKeyword),
    setOption(ID, MinMessage, ChatbotCodeLink, FlowCodeLink, MinKeyword, Option).

% Descripcion: Crea un flujo.
% Dom: ID (int) X NameMSG (string) X Options (list) X Flow (var)
% M. Primaria: flow/4
% M. Secundaria: downcase_atom/2, addElementsInList/3, setFlow/4
flow(ID, NameMSG, Options, Flow):-
    downcase_atom(NameMSG, MinNameMSG),
    addElementsInList(Options, [], OptionList),
    setFlow(ID, MinNameMSG, OptionList, Flow).

% Descripcion: Crea un chatbot.
% Dom: ID (int) X Name (string) X WelcomeMessage (string) X
%      StartFlowID (int) X Flows (list) X Chatbot (var)
% M. Primaria: chatbot/6
% M. Secundaria: downcase_atom/2, addElementsInList/3, setChatbot/6
chatbot(ID, Name, WelcomeMessage, StartFlowID, Flows, Chatbot):-
    downcase_atom(Name, MinName),
    downcase_atom(WelcomeMessage, MinWelcomeMessage),
    addElementsInList(Flows, [], FlowList),
    setChatbot(ID, MinName, MinWelcomeMessage, StartFlowID, FlowList, Chatbot).

% Descripcion: Crea un sistema.
% Dom: Name (string) X StartChatbotID (int) X Chatbots (list) X System (var)
% M. Primaria: system/4
% M. Secundaria: downcase_atom/2, addElementsInList/3, setSystem/7
system(Name, StartChatbotID, Chatbots, System):-
    getDate(Date),
    downcase_atom(Name, MinName),
    addElementsInList(Chatbots, [], ChatbotList),
    setSystem(Date, MinName, [], [], StartChatbotID, ChatbotList, System).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega una opcion a la lista de opciones del flujo.
% Dom: Flow (list) X Option (list) X NewFlow (var)
% M. Primaria: flowAddOption/3
% M. Secundaria: getFlowID/2, getFlowNameMSG/2, getFlowOptionList/2, 
%                addElementsInList/3, setFlow/4
flowAddOption(Flow, Option, NewFlow):-
    getFlowID(Flow, ID),
    getFlowNameMSG(Flow, NameMSG),
    getFlowOptionList(Flow, CurrentOptionList),

    addElementsInList([Option], CurrentOptionList, NewOptionList),

    setFlow(ID, NameMSG, NewOptionList, NewFlow).

% Descripcion: Agrega un flujo a la lista de flujos de un chatbot.
% Dom: Chatbot (list) X Flow (list) X NewChatbot (var)
% M. Primaria: chatbotAddFlow/3
% M. Secundaria: getChatbotID/2, getChatbotName/2, getChatbotWelcomeMessage, getChatbotStartFlowID/2,
%                getChatbotFlowList/2, addElementsInList/3, setChatbot/6
chatbotAddFlow(Chatbot, Flow, NewChatbot):-
    getChatbotID(Chatbot, ID),
    getChatbotName(Chatbot, Name),
    getChatbotWelcomeMessage(Chatbot, WelcomeMessage),
    getChatbotStartFlowID(Chatbot, StartFlowID),
    getChatbotFlowList(Chatbot, CurrentFlowList),

    addElementsInList([Flow], CurrentFlowList, NewFlowList),

    setChatbot(ID, Name, WelcomeMessage, StartFlowID, NewFlowList, NewChatbot).