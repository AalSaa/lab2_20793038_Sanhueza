:- module(tda_chathistory_20793038_SanhuezaVega, [setChatHistoryOfUser/3]).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un historial de chat para un usuario.
% Dom: Username (string) X RecordList (list) X ChatHistoryOfUser (var)
setChatHistoryOfUser(Username, RecordList, ChatHistoryOfUser):-
    ChatHistoryOfUser = [Username, RecordList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el nombre del usuario que el pertenece el historial de chat.
% Dom: ChatHistoryOfUser (list) X CHOUsername (var)
getCHOUsername(ChatHistoryOfUser, CHOUsername):-
    setChatHistoryOfUser(CHOUsername, _, ChatHistoryOfUser).

% Descripcion: Obtiene la lista de registros del historial de chat.
% Dom: ChatHistoryOfUser (list) X CHOURecord (var)
getCHOURecordList(ChatHistoryOfUser, CHOURecord):-
    setChatHistoryOfUser(_, CHOURecord, ChatHistoryOfUser).