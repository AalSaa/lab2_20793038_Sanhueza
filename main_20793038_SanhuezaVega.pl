:- module(main_20793038_SanhuezaVega, [option/6, flow/4, flowAddOption/3, chatbot/6, chatbotAddFlow/3, system/4, systemAddChatbot/3, systemAddUser/3, systemLogin/3, systemLogout/2, systemTalkRec/3, systemSynthesis/3]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_date_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).
:- use_module(tda_chathistory_20793038_SanhuezaVega).
:- use_module(tda_system_20793038_SanhuezaVega).

% ######################################## MAIN ##############################################

% Aqui se encuentran todos los predicados principales para el proyecto.

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea una opcion.
% Dom: ID (int) X Message (string) X ChatbotCodeLink (string) X
%      FlowCodeLink (string) X Keyword (list)
% Rec: Option (list)
% Metodo: -
option(ID, Message, ChatbotCodeLink, FlowCodeLink, Keyword, Option):-
    downcase_atom(Message, MinMessage),
    stringDownInList(Keyword, [], MinKeyword),
    setOption(ID, MinMessage, ChatbotCodeLink, FlowCodeLink, MinKeyword, Option).

% Descripcion: Crea un flujo.
% Dom: ID (int) X NameMSG (string) X Options (list)
% Rec: Flow (list)
% Metodo: -
flow(ID, NameMSG, Options, Flow):-
    downcase_atom(NameMSG, MinNameMSG),
    addElementsInList(Options, [], OptionList),
    setFlow(ID, MinNameMSG, OptionList, Flow).

% Descripcion: Crea un chatbot.
% Dom: ID (int) X Name (string) X WelcomeMessage (string) X
%      StartFlowID (int) X Flows (list)
% Rec: Chatbot (list)
% Metodo: -
chatbot(ID, Name, WelcomeMessage, StartFlowID, Flows, Chatbot):-
    downcase_atom(Name, MinName),
    downcase_atom(WelcomeMessage, MinWelcomeMessage),
    addElementsInList(Flows, [], FlowList),
    setChatbot(ID, MinName, MinWelcomeMessage, StartFlowID, FlowList, Chatbot).

% Descripcion: Crea un sistema.
% Dom: Name (string) X StartChatbotID (int) X Chatbots (list)
% Rec: System (list)
% Metodo: -
system(Name, StartChatbotID, Chatbots, System):-
    getDate(Date),
    downcase_atom(Name, MinName),
    addElementsInList(Chatbots, [], ChatbotList),
    setSystem(Date, MinName, [], [], StartChatbotID, ChatbotList, System).

% Descripcion: Crea un string que contiene todos los registros de un usuario.
% Dom: System (string) X Username (string)
% Rec: String (string)
% Metodo: -
systemSynthesis(System, Username, String):-
    getSystemUserList(System, UserList),
    downcase_atom(Username, MinUsername),
    idExists(MinUsername, UserList),
    getSystemChatHistory(System, ChatHistory),
    getElementByID(MinUsername, ChatHistory, CHOU),
    getCHOURecordList(CHOU, CHOURecordList),
    setSrtForAllRecords(CHOURecordList, '', String).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega una opcion a la lista de opciones del flujo.
% Dom: Flow (list) X Option (list)
% Rec: NewFlow (list)
% Metodo: -
flowAddOption(Flow, Option, NewFlow):-
    getFlowID(Flow, ID),
    getFlowNameMSG(Flow, NameMSG),
    getFlowOptionList(Flow, CurrentOptionList),

    addElementsInList([Option], CurrentOptionList, NewOptionList),

    setFlow(ID, NameMSG, NewOptionList, NewFlow).

% Descripcion: Agrega un flujo a la lista de flujos de un chatbot.
% Dom: Chatbot (list) X Flow (list)
% Rec: NewChatbot (list)
% Metodo: -
chatbotAddFlow(Chatbot, Flow, NewChatbot):-
    getChatbotID(Chatbot, ID),
    getChatbotName(Chatbot, Name),
    getChatbotWelcomeMessage(Chatbot, WelcomeMessage),
    getChatbotStartFlowID(Chatbot, StartFlowID),
    getChatbotFlowList(Chatbot, CurrentFlowList),

    addElementsInList([Flow], CurrentFlowList, NewFlowList),

    setChatbot(ID, Name, WelcomeMessage, StartFlowID, NewFlowList, NewChatbot).

% Descripcion: Agrega un chatbot en el sistema.
% Dom: System (list) X Chatbot (list)
% Rec: NewSystem (list)
% Metodo: -
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
% Dom: System (list) X Username (string)
% Rec: NewSystem (list)
% Metodo: -
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
% Dom: System (list) X Username (string)
% Rec: NewSystem (list)
% Metodo: -
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
% Dom: System (list)
% Rec: NewSystem (list)
% Metodo: -
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

% Descripcion: Interactua con un chatbot del sistema.
% Dom: System (list) X Message (string)
% Rec: NewSystem (list)
% Metodo: -
systemTalkRec(System, Message, NewSystem):-
    getSystemUserList(System, CurrentUserList),
    someoneLoggedIn(CurrentUserList),
    getCurrentOptionList(System, CurrentOptionList),
    setSystemByTalk(System, Message, CurrentOptionList, NewSystem).
