:- module(tda_chathistory_20793038_SanhuezaVega, [setChatHistoryOfUser/3, setStrRecordC1/5, setStrRecordC2/3, setSrtForAllRecords/3, getCHOURecordList/2, addRecordInChatHistoryList/5]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_date_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).
:- use_module(tda_system_20793038_SanhuezaVega).

% ######################################## TDA CHAT HISTORY ##################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a un historial de chat.
% Dentro se guardaran listas que contienen el historial de chat de cada usuario.

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un historial de chat para un usuario.
% Dom: Username (string) X RecordList (list)
% Rec: ChatHistoryOfUser (list)
% Metodo: -
setChatHistoryOfUser(Username, RecordList, ChatHistoryOfUser):-
    ChatHistoryOfUser = [Username, RecordList].

% Descripcion: Construye un registro si el usuario interactuó correctamente con el chatbot.
% Dom: System (list) X Message (list) X CBCodelink (int) X FCodelink (int)
% Rec: StrRecord (string)
% Metodo: -
setStrRecordC1(System, Message, CBCodelink, FCodelink, StrRecord):-
    getSystemUserList(System, UserList),
    getUserLogged(UserList, UserLogged),
    getUsername(UserLogged, Username),

    setStrRecordUserDate(Username, Message, StrRecordUD),
    setStrRecordCBAndFDateC1(System, CBCodelink, FCodelink, StrRecordCBFD),
    setStrRecordOptionsDateC1(System, CBCodelink, FCodelink, StrRecordOPD),

    atom_concat(StrRecordUD, StrRecordCBFD, Str1),
    atom_concat(Str1, StrRecordOPD, StrRecord).

% Descripcion: Construye un registro si el usuario no interactuó correctamente con el chatbot.
% Dom: System (list) X Message (string)
% Rec: StrRecord (string)
% Metodo: -
setStrRecordC2(System, Message, StrRecord):-
    getSystemUserList(System, UserList),
    getUserLogged(UserList, UserLogged),
    getUsername(UserLogged, Username),
    
    setStrRecordUserDate(Username, Message, StrRecordUD),
    setStrRecordCBAndFDateC2(System, StrRecordCBFD),
    setStrRecordOptionsDateC2(System, StrRecordOPD),

    atom_concat(StrRecordUD, StrRecordCBFD, Str1),
    atom_concat(Str1, StrRecordOPD, StrRecord).

% Descripcion: Construye la parte de los datos del usuario en el registro.
% Dom: Username (string) X Message (string)
% Rec: StrRecordUD (string)
% Metodo: -
setStrRecordUserDate(Username, Message, StrRecordUD):-
    getDate(Date),
    atom_concat(Date, ' - ', Str1),
    atom_concat(Str1, Username, Str2),
    atom_concat(Str2, ': ', Str3),
    atom_concat(Str3, Message, Str4),
    atom_concat(Str4, '\n', StrRecordUD).

% Descripcion: Construye la parte del chatbot y flujo en un registro si el usuario interactuó correctamente con el chatbot.
% Dom: System (list) X CBCodelink (int) X FCodelink (int)
% Rec: StrRecordCBFD (string)
% Metodo: -
setStrRecordCBAndFDateC1(System, CBCodelink, FCodelink, StrRecordCBFD):-
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(CBCodelink, SystemChatbotList, CurrentChatbot),
    getChatbotFlowList(CurrentChatbot, ChatbotFlowList),
    getElementByID(FCodelink, ChatbotFlowList, CurrentFlow),

    getChatbotName(CurrentChatbot, ChatbotName),
    getFlowNameMSG(CurrentFlow, FlowNameMSG),

    getDate(Date),
    atom_concat(Date, ' - ', Str1),
    atom_concat(Str1, ChatbotName , Str2),
    atom_concat(Str2, ': ', Str3),
    atom_concat(Str3, FlowNameMSG, Str4),
    atom_concat(Str4, '\n', StrRecordCBFD).


% Descripcion: Construye la parte del chatbot y flujo en un registro si el usuario no interactuó correctamente con el chatbot.
% Dom: System (list)
% Rec: StrRecordCBFD (string)
% Metodo: -
setStrRecordCBAndFDateC2(System, StrRecordCBFD):-
    getCurrentCBAndFCodelink(System, CurrentCBCodelink, CurrentFCodelink),
    getSystemChatbotList(System, SystemChatbotList),
    getElementByID(CurrentCBCodelink, SystemChatbotList, CurrentChatbot),
    getChatbotFlowList(CurrentChatbot, ChatbotFlowList),
    getElementByID(CurrentFCodelink, ChatbotFlowList, CurrentFlow),

    getChatbotName(CurrentChatbot, ChatbotName),
    getFlowNameMSG(CurrentFlow, FlowNameMSG),

    getDate(Date),
    atom_concat(Date, ' - ', Str1),
    atom_concat(Str1, ChatbotName , Str2),
    atom_concat(Str2, ': ', Str3),
    atom_concat(Str3, FlowNameMSG, Str4),
    atom_concat(Str4, '\n', StrRecordCBFD).

% Descripcion: Construye la parte de las opciones en un registro si el usuario interactuó correctamente con el chatbot.
% Dom: System (list) X CBCodelink (int) X FCodelink (int)
% Rec: StrRecordOPD (string)
% Metodo: -
setStrRecordOptionsDateC1(System, CBCodelink, FCodelink, StrRecordOPD):-
    getOptionListByCodelinks(System, CBCodelink, FCodelink, Optionlist),

    setStrRecordOptionsDate(Optionlist, '', FinalStr),
    StrRecordOPD = FinalStr.

% Descripcion: Construye la parte de las opciones en un registro si el usuario no interactuó correctamente con el chatbot.
% Dom: System (list)
% Rec: StrRecordOPD (string)
% Metodo: -
setStrRecordOptionsDateC2(System, StrRecordOPD):-
    getCurrentOptionList(System, CurrentOptionList),
    setStrRecordOptionsDate(CurrentOptionList, '', FinalStr),
    StrRecordOPD = FinalStr.

% Descripcion: Construye un string a partir de los mensajes de las opciones del registro.
% Dom: OptionList (list) X UpdatedStr (string)
% Rec: FinalStr (string)
% Metodo: Recursion
setStrRecordOptionsDate([], UpdatedStr, FinalStr):-
    FinalStr = UpdatedStr, !.

setStrRecordOptionsDate([First | Rest], UpdatedStrA, FinalStr):-
    getOptionMessage(First, OptionMessage),
    atom_concat(UpdatedStrA, OptionMessage, UpdatedStrB),
    atom_concat(UpdatedStrB, '\n', UpdatedStrC),
    setStrRecordOptionsDate(Rest, UpdatedStrC, FinalStr).

% Descripcion: Construye un string que contiene todos los registros de un usuario.
% Dom: RecordList (list) X UpdatedStr (string)
% Rec: FinalStr (string)
% Metodo: Recursion
setSrtForAllRecords([], UpdatedStr, FinalStr):-
    FinalStr = UpdatedStr, !.

setSrtForAllRecords([First | Rest], UpdatedStrA, FinalStr):-
    atom_concat(UpdatedStrA, First, UpdatedStrB),
    atom_concat(UpdatedStrB, '\n', UpdatedStrC),
    setSrtForAllRecords(Rest, UpdatedStrC, FinalStr).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el nombre del usuario que el pertenece el historial de chat.
% Dom: ChatHistoryOfUser (list)
% Rec: CHOUsername (string)
% Metodo: -
getCHOUsername(ChatHistoryOfUser, CHOUsername):-
    setChatHistoryOfUser(CHOUsername, _, ChatHistoryOfUser).

% Descripcion: Obtiene la lista de registros del historial de chat.
% Dom: ChatHistoryOfUser (list)
% Rec: CHOURecord (list)
% Metodo: -
getCHOURecordList(ChatHistoryOfUser, CHOURecord):-
    setChatHistoryOfUser(_, CHOURecord, ChatHistoryOfUser).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega un registro a un historial de chat de un usuario.
% Dom: ChatHistoryOfUser (list) X NewRecord (string)
% Rec: NewChatHistoryOfUser (list)
% Metodo: -
addRecordInCHOU(ChatHistoryOfUser, NewRecord, NewChatHistoryOfUser):-
    getCHOUsername(ChatHistoryOfUser, CHOUsername),
    getCHOURecordList(ChatHistoryOfUser, CHOURecord),
    append(CHOURecord, [NewRecord], NewCHOURecord),
    setChatHistoryOfUser(CHOUsername, NewCHOURecord, NewChatHistoryOfUser).

% Descripcion: Agrega un registro a un historial de chat de un usuario contenido en una
%              lista de chat history.
% Dom: ChatHistoryList (list) X Username (string) X NewRecord (string) X UpdatedCHL (list)
% Rec: FinalCHL (list)
% Metodo: Recursion
addRecordInChatHistoryList([], _, _, UpdatedCHL, FinalCHL):-
    UpdatedCHL = FinalCHL, !.

addRecordInChatHistoryList([First | Rest], Username, NewRecord, UpdatedCHLA, FinalCHL):-
    getCHOUsername(First, CHOUsername),
    CHOUsername == Username,
    addRecordInCHOU(First, NewRecord, UpdatedFirst),
    append(UpdatedCHLA, [UpdatedFirst], UpdatedCHLB),
    addRecordInChatHistoryList(Rest, Username, NewRecord, UpdatedCHLB, FinalCHL), !.

addRecordInChatHistoryList([First | Rest], Username, NewRecord, UpdatedCHLA, FinalCHL):-
    append(UpdatedCHLA, [First], UpdatedCHLB),
    addRecordInChatHistoryList(Rest, Username, NewRecord, UpdatedCHLB, FinalCHL).