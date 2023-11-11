:- module(tda_chathistory_20793038_SanhuezaVega, [setChatHistoryOfUser/3, setStrRecord/3, addRecordInChatHistoryList/5]).

:- use_module(tda_tools_20793038_SanhuezaVega).
:- use_module(tda_option_20793038_SanhuezaVega).
:- use_module(tda_flow_20793038_SanhuezaVega).
:- use_module(tda_chatbot_20793038_SanhuezaVega).
:- use_module(tda_date_20793038_SanhuezaVega).
:- use_module(tda_user_20793038_SanhuezaVega).
:- use_module(tda_system_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un historial de chat para un usuario.
% Dom: Username (string) X RecordList (list) X ChatHistoryOfUser (var)
setChatHistoryOfUser(Username, RecordList, ChatHistoryOfUser):-
    ChatHistoryOfUser = [Username, RecordList].

% Descripcion: Construye un registro de una interaccion realizado por el usuario.
% Dom: System (list) X Message (string) X StrRecord (var)
setStrRecord(System, Message, StrRecord):-
    getSystemUserList(System, UserList),
    getUserLogged(UserList, UserLogged),
    getUsername(UserLogged, Username),
    
    setStrRecordUserDate(Username, Message, StrRecordUD),
    setStrRecordCBAndFDate(System, StrRecordCBFD),
    setStrRecordOptionsDate(System, StrRecordOPD),

    atom_concat(StrRecordUD, StrRecordCBFD, Str1),
    atom_concat(Str1, StrRecordOPD, StrRecord).

% Descripcion: Construye la parte de los datos del usuario en el registro.
% Dom: Username (string) X Message (string) X StrRecordUD (var)
setStrRecordUserDate(Username, Message, StrRecordUD):-
    getDate(Date),
    atom_concat(Date, ' - ', Str1),
    atom_concat(Str1, Username, Str2),
    atom_concat(Str2, ': ', Str3),
    atom_concat(Str3, Message, Str4),
    atom_concat(Str4, '\n', StrRecordUD).

% Descripcion: Construye la parte de los datos del chatbot y el flujo en el registro.
% Dom: System (list) X StrRecordCBFD (var)
setStrRecordCBAndFDate(System, StrRecordCBFD):-
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

% Descripcion: Construye la parte de los datos de las opciones en el registro.
% Dom: System (list) X StrRecordOPD (var)
setStrRecordOptionsDate(System, StrRecordOPD):-
    getCurrentOptionList(System, CurrentOptionList),
    setStrRecordOptionsDate(CurrentOptionList, '', FinalStr),
    StrRecordOPD = FinalStr.

% Descripcion: Construye un string a partir de los mensajes de las opciones del registro.
% Dom: OptionList (list) X UpdatedStr (string) X FinalStr (var)
setStrRecordOptionsDate([], UpdatedStr, FinalStr):-
    FinalStr = UpdatedStr, !.

setStrRecordOptionsDate([First | Rest], UpdatedStrA, FinalStr):-
    getOptionMessage(First, OptionMessage),
    atom_concat(UpdatedStrA, OptionMessage, UpdatedStrB),
    atom_concat(UpdatedStrB, '\n', UpdatedStrC),
    setStrRecordOptionsDate(Rest, UpdatedStrC, FinalStr).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el nombre del usuario que el pertenece el historial de chat.
% Dom: ChatHistoryOfUser (list) X CHOUsername (var)
getCHOUsername(ChatHistoryOfUser, CHOUsername):-
    setChatHistoryOfUser(CHOUsername, _, ChatHistoryOfUser).

% Descripcion: Obtiene la lista de registros del historial de chat.
% Dom: ChatHistoryOfUser (list) X CHOURecord (var)
getCHOURecordList(ChatHistoryOfUser, CHOURecord):-
    setChatHistoryOfUser(_, CHOURecord, ChatHistoryOfUser).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega un registro a un historial de chat de un usuario.
% Dom: ChatHistoryOfUser (list) X NewRecord (string) X NewChatHistoryOfUser (var)
addRecordInCHOU(ChatHistoryOfUser, NewRecord, NewChatHistoryOfUser):-
    getCHOUsername(ChatHistoryOfUser, CHOUsername),
    getCHOURecordList(ChatHistoryOfUser, CHOURecord),
    append(CHOURecord, [NewRecord], NewCHOURecord),
    setChatHistoryOfUser(CHOUsername, NewCHOURecord, NewChatHistoryOfUser).

% Descripcion: Agrega un registro a un historial de chat de un usuario contenido en una
%              lista de chat history.
% Dom: ChatHistoryList (list) X Username (string) X NewRecord (string) X UpdatedCHL (list)
%      FinalCHL (var)
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