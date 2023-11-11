:- module(tda_system_20793038_SanhuezaVega, [setSystem/7, getSystemDate/2, getSystemName/2, getSystemUserList/2, getSystemChatHistory/2, getSystemStartCBID/2, getSystemChatbotList/2, getCurrentOptionList/2, getCurrentCBAndFCodelink/3]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un sistema.
% Dom: Date (string) X Name (string) X UserList (list) X ChatHistory (list) X
%      StartChatbotID (int) X ChatbotList (list) X System (var)
setSystem(Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList, System):-
    System = [Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene la fecha de creacion de un sistema.
% Dom: System (list) X SystemDate (var)
getSystemDate(System, SystemDate):-
    setSystem(SystemDate, _, _, _, _, _, System).

% Descripcion: Obtiene el nombre de un sistema.
% Dom: System (list) X SystemName (var)
getSystemName(System, SystemName):-
    setSystem(_, SystemName, _, _, _, _, System).

% Descripcion: Obtiene la lista de usuarios de un sistema.
% Dom: System (list) X SystemUserList (var)
getSystemUserList(System, SystemUserList):-
    setSystem(_, _, SystemUserList, _, _, _, System).

% Descripcion: Obtiene el historial de un sistema.
% Dom: System (list) X SystemChatHistory (var)
getSystemChatHistory(System, SystemChatHistory):-
    setSystem(_, _, _, SystemChatHistory, _, _, System).

% Descripcion: Obtiene el id del chatbot inicial de un sistema.
% Dom: System (list) X SystemStartCBID (var)
getSystemStartCBID(System, SystemStartCBID):-
    setSystem(_, _, _, _, SystemStartCBID, _, System).

% Descripcion: Obtiene la lista de chatbots de un sistema.
% Dom: System (list) X SystemChatbotList (var)
getSystemChatbotList(System, SystemChatbotList):-
    setSystem(_, _, _, _, _, SystemChatbotList, System).

% Descripcion: Obtiene los codelinks actuales del sistema.
% Dom: System (list) X CurrentCBCodelink (var) X CurrentFCodelink (var)
getCurrentCBAndFCodelink(System, CurrentCBCodelink, CurrentFCodelink):-
    getSystemUserList(System, UserList),
    getUserLogged(UserList, UserLogged),
    getUserCBCodelink(UserLogged, UserCBCodelink),
    getUserFCodelink(UserLogged, UserFCodelink),
    \+ UserCBCodelink == -1,
    \+ UserFCodelink == -1,
    CurrentCBCodelink = UserCBCodelink,
    CurrentFCodelink = UserFCodelink, !.

getCurrentCBAndFCodelink(System, CurrentCBCodelink, CurrentFCodelink):-
    getInitialCBAndFCodelink(System, InitialCBCodelink, InitialFCodelink),
    CurrentCBCodelink = InitialCBCodelink,
    CurrentFCodelink = InitialFCodelink.

% Descripcion: Obtiene los codelinks iniciales del sistema.
% Dom: System (list) X InitialCBCodelink (var) X InitialFCodelink (var)
getInitialCBAndFCodelink(System, InitialCBCodelink, InitialFCodelink):-
    getSystemStartCBID(System, StartCBID),
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(StartCBID, SystemChatbotList, SelectedChatbot),
    getChatbotStartFlowID(SelectedChatbot, StartFlowID),
    getChatbotFlowList(SelectedChatbot, ChatbotFlowList),
    getElementByID(StartFlowID, ChatbotFlowList, _),
    InitialCBCodelink = StartCBID,
    InitialFCodelink = StartFlowID.

% Descripcion: Obtiene la lista de opciones actual.
% Dom: System (list) X CurrentOptionList (var)
getCurrentOptionList(System, CurrentOptionList):-
    getCurrentCBAndFCodelink(System, CurrentCBCodelink, CurrentFCodelink),
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(CurrentCBCodelink, SystemChatbotList, CurrentChatbot),
    getChatbotFlowList(CurrentChatbot, ChatbotFlowList),
    getElementByID(CurrentFCodelink, ChatbotFlowList, CurrentFlow),
    getFlowOptionList(CurrentFlow, FlowOptionList),
    CurrentOptionList = FlowOptionList.