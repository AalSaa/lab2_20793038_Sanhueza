:- module(tda_main_20793038_SanhuezaVega, [option/6, flow/4, flowAddOption/3, chatbot/6, chatbotAddFlow/3, system/4, systemAddChatbot/3, systemAddUser/3, systemLogin/3, systemLogout/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_date_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).
:- use_module(tda_chathistory_20793038_SanhuezaVega).
:- use_module(tda_system_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list) X Option (var)
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    downcase_atom(Message, MinMessage),
    stringDownInList(Keyword, [], MinKeyword),
    setOption(ID, MinMessage, ChatbotCodeLink, FlowCodeLink, MinKeyword, Option).

% Descripcion: Crea un flujo.
% Dom: ID (int) X NameMSG (string) X Options (list) X Flow (var)
flow(ID, NameMSG, Options, Flow):-
    downcase_atom(NameMSG, MinNameMSG),
    addElementsInList(Options, [], OptionList),
    setFlow(ID, MinNameMSG, OptionList, Flow).

% Descripcion: Crea un chatbot.
% Dom: ID (int) X Name (string) X WelcomeMessage (string) X
%      StartFlowID (int) X Flows (list) X Chatbot (var)
chatbot(ID, Name, WelcomeMessage, StartFlowID, Flows, Chatbot):-
    downcase_atom(Name, MinName),
    downcase_atom(WelcomeMessage, MinWelcomeMessage),
    addElementsInList(Flows, [], FlowList),
    setChatbot(ID, MinName, MinWelcomeMessage, StartFlowID, FlowList, Chatbot).

% Descripcion: Crea un sistema.
% Dom: Name (string) X StartChatbotID (int) X Chatbots (list) X System (var)
system(Name, StartChatbotID, Chatbots, System):-
    getDate(Date),
    downcase_atom(Name, MinName),
    addElementsInList(Chatbots, [], ChatbotList),
    setSystem(Date, MinName, [], [], StartChatbotID, ChatbotList, System).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega una opcion a la lista de opciones del flujo.
% Dom: Flow (list) X Option (list) X NewFlow (var)
flowAddOption(Flow, Option, NewFlow):-
    getFlowID(Flow, ID),
    getFlowNameMSG(Flow, NameMSG),
    getFlowOptionList(Flow, CurrentOptionList),

    addElementsInList([Option], CurrentOptionList, NewOptionList),

    setFlow(ID, NameMSG, NewOptionList, NewFlow).

% Descripcion: Agrega un flujo a la lista de flujos de un chatbot.
% Dom: Chatbot (list) X Flow (list) X NewChatbot (var)
chatbotAddFlow(Chatbot, Flow, NewChatbot):-
    getChatbotID(Chatbot, ID),
    getChatbotName(Chatbot, Name),
    getChatbotWelcomeMessage(Chatbot, WelcomeMessage),
    getChatbotStartFlowID(Chatbot, StartFlowID),
    getChatbotFlowList(Chatbot, CurrentFlowList),

    addElementsInList([Flow], CurrentFlowList, NewFlowList),

    setChatbot(ID, Name, WelcomeMessage, StartFlowID, NewFlowList, NewChatbot).

% Descripcion: Agrega un chatbot en el sistema.
% Dom: System (list) X Chatbot (list) X NewSystem (var)
systemAddChatbot(System, Chatbot, NewSystem):-
    getSystemDate(System, Date),
    getSystemName(System, Name),
    getSystemUserList(System, UserList),
    getSystemChatHistory(System, ChatHistory),
    getSystemStartCBID(System, StartCBID),
    getSystemChatbotList(System, CurrentChatbotList),

    addElementsInList([Chatbot], CurrentChatbotList, NewChatbotList),

    setSystem(Date, Name, UserList, ChatHistory, StartCBID, NewChatbotList, NewSystem).

% Descripcion: Agrega un usuario al sistema.
% Dom: System (list) X Username (string) X NewSystem (var)
systemAddUser(System, Username, NewSystem):-
    downcase_atom(Username, MinUsername),
    getSystemDate(System, Date),
    getSystemName(System, Name),
    getSystemUserList(System, CurrentUserList),
    getSystemChatHistory(System, CurrentChatHistory),
    getSystemStartCBID(System, StartCBID),
    getSystemChatbotList(System, ChatbotList),

    setUser(MinUsername, 0, -1, -1, NewUser),
    addElementsInList([NewUser], CurrentUserList, NewUserList),

    setChatHistoryOfUser(MinUsername, [], ChatHistoryOfUser),
    addElementsInList([ChatHistoryOfUser], CurrentChatHistory, NewChatHistory),
    
    setSystem(Date, Name, NewUserList, NewChatHistory, StartCBID, ChatbotList, NewSystem).

% Descripcion: Loguea a un usuario en el sistema.
% Dom: System (list) X Username (string) X NewSystem (var)
systemLogin(System, Username, NewSystem):-
    getSystemUserList(System, CurrentUserList),
    \+someoneLoggedIn(CurrentUserList),
    downcase_atom(Username, MinUsername),
    idExists(MinUsername, CurrentUserList),
    getSystemDate(System, Date),
    getSystemName(System, Name),
    getSystemChatHistory(System, ChatHistory),
    getSystemStartCBID(System, StartCBID),
    getSystemChatbotList(System, ChatbotList),

    login(MinUsername, CurrentUserList, [], NewUserList),

    setSystem(Date, Name, NewUserList, ChatHistory, StartCBID, ChatbotList, NewSystem).

% Descripcion: Desloguea a un usuario en el sistema.
% Dom: System (list) X NewSystem (var)
systemLogout(System, NewSystem):-
    getSystemUserList(System, CurrentUserList),
    someoneLoggedIn(CurrentUserList),

    getSystemDate(System, Date),
    getSystemName(System, Name),
    getSystemChatHistory(System, ChatHistory),
    getSystemStartCBID(System, StartCBID),
    getSystemChatbotList(System, ChatbotList),

    logout(CurrentUserList, [] ,NewUserList),

    setSystem(Date, Name, NewUserList, ChatHistory, StartCBID, ChatbotList, NewSystem).

