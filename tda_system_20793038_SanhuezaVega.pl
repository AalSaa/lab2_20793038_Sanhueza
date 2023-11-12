:- module(tda_system_20793038_SanhuezaVega, [setSystem/7, getSystemDate/2, getSystemName/2, getSystemUserList/2, getSystemChatHistory/2, getSystemStartCBID/2, getSystemChatbotList/2, getCurrentCBAndFCodelink/3, getCurrentOptionList/2, getOptionListByCodelinks/4, setSystemByTalk/4]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).
:- use_module(tda_chathistory_20793038_SanhuezaVega).

% ######################################## TDA SYSTEM ########################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a un sistema.
% Dentro se guardara la fecha de creacion, el nombre del sistema, el id del primer chatbot a
% utilizar, una lista de usuarios, un historial del uso de los chatbots y una lista de
% chatbots.

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un sistema.
% Dom: Date (string) X Name (string) X UserList (list) X ChatHistory (list) X
%      StartChatbotID (int) X ChatbotList (list)
% Rec: System (list)
% Metodo: -
setSystem(Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList, System):-
    System = [Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene la fecha de creacion de un sistema.
% Dom: System (list)
% Rec: SystemDate (string)
% Metodo: -
getSystemDate(System, SystemDate):-
    setSystem(SystemDate, _, _, _, _, _, System).

% Descripcion: Obtiene el nombre de un sistema.
% Dom: System (list)
% Rec: SystemName (string)
% Metodo: -
getSystemName(System, SystemName):-
    setSystem(_, SystemName, _, _, _, _, System).

% Descripcion: Obtiene la lista de usuarios de un sistema.
% Dom: System (list)
% Rec: SystemUserList (list)
% Metodo: -
getSystemUserList(System, SystemUserList):-
    setSystem(_, _, SystemUserList, _, _, _, System).

% Descripcion: Obtiene el historial de un sistema.
% Dom: System (list)
% Rec: SystemChatHistory (list)
% Metodo: -
getSystemChatHistory(System, SystemChatHistory):-
    setSystem(_, _, _, SystemChatHistory, _, _, System).

% Descripcion: Obtiene el id del chatbot inicial de un sistema.
% Dom: System (list)
% Rec: SystemStartCBID (int)
% Metodo: -
getSystemStartCBID(System, SystemStartCBID):-
    setSystem(_, _, _, _, SystemStartCBID, _, System).

% Descripcion: Obtiene la lista de chatbots de un sistema.
% Dom: System (list)
% Rec: SystemChatbotList (list)
% Metodo: -
getSystemChatbotList(System, SystemChatbotList):-
    setSystem(_, _, _, _, _, SystemChatbotList, System).

% Descripcion: Obtiene los codelinks actuales del sistema.
% Dom: System (list)
% Rec: CurrentCBCodelink (int) X CurrentFCodelink (int)
% Metodo: -
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
% Dom: System (list)
% Rec: InitialCBCodelink (int) X InitialFCodelink (int)
% Metodo: -
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
% Dom: System (list)
% Rec: CurrentOptionList (list)
% Metodo: -
getCurrentOptionList(System, CurrentOptionList):-
    getCurrentCBAndFCodelink(System, CurrentCBCodelink, CurrentFCodelink),
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(CurrentCBCodelink, SystemChatbotList, CurrentChatbot),
    getChatbotFlowList(CurrentChatbot, ChatbotFlowList),
    getElementByID(CurrentFCodelink, ChatbotFlowList, CurrentFlow),
    getFlowOptionList(CurrentFlow, FlowOptionList),
    CurrentOptionList = FlowOptionList.

% Descripcion: Obtiene una lista de opciones segun los codelinks indicados.
% Dom: System (list) CBCodelink (int) X FCodelink (int)
% Rec: CurrentOptionList (list)
% Metodo: -
getOptionListByCodelinks(System, CBCodelink, FCodelink, OptionList):-
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(CBCodelink, SystemChatbotList, Chatbot),
    getChatbotFlowList(Chatbot, ChatbotFlowList),
    getElementByID(FCodelink, ChatbotFlowList, Flow),
    getFlowOptionList(Flow, FlowOptionList),
    OptionList = FlowOptionList.

% ######################################## MODIFICADOR #######################################

% Descripcion: Actualiza el sistema segun la interaccion entre el usuario y un chatbot.
% Dom: System (list) X Message (string) X CurrentOptionList (list)
% Rec: NewSystem (list)
% Metodo: -
setSystemByTalk(System, Message, CurrentOptionList, NewSystem):-
    getOptionByMessage(Message, CurrentOptionList, SelectedOption),
    getOptionCBCodelink(SelectedOption, OptionCBCodelink),
    getOptionFCodelink(SelectedOption, OptionFCodelink),
    getOptionListByCodelinks(System, OptionCBCodelink, OptionFCodelink, _),

    getSystemUserList(System, CurrentUserList),
    updateLoggedUser(OptionCBCodelink, OptionFCodelink, CurrentUserList, [], NewUserList),

    setStrRecordC1(System, Message, OptionCBCodelink, OptionFCodelink, NewRecord),
    getSystemChatHistory(System, CurrentChatHistory),
    getUserLogged(CurrentUserList, UserLogged),
    getUsername(UserLogged, Username),
    addRecordInChatHistoryList(CurrentChatHistory, Username, NewRecord, [], NewChatHistory),

    getSystemDate(System, SystemDate),
    getSystemName(System, SystemName),
    getSystemStartCBID(System, SystemStartCBID),
    getSystemChatbotList(System, SystemChatbotList),
    setSystem(SystemDate, SystemName, NewUserList, NewChatHistory, SystemStartCBID, SystemChatbotList, NewSystem), !.

setSystemByTalk(System, Message, _, NewSystem):-
    setStrRecordC2(System, Message, NewRecord),
    getSystemChatHistory(System, CurrentChatHistory),
    getSystemUserList(System, CurrentUserList),
    getUserLogged(CurrentUserList, UserLogged),
    getUsername(UserLogged, Username),
    addRecordInChatHistoryList(CurrentChatHistory, Username, NewRecord, [], NewChatHistory),

    getSystemDate(System, SystemDate),
    getSystemName(System, SystemName),
    getSystemStartCBID(System, SystemStartCBID),
    getSystemChatbotList(System, SystemChatbotList),
    setSystem(SystemDate, SystemName, CurrentUserList, NewChatHistory, SystemStartCBID, SystemChatbotList, NewSystem).