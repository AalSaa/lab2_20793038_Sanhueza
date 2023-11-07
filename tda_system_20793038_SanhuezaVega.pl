:- module(tda_system, [setSystem/7, getSystemDate/2, getSystemName/2, getSystemUserList/2, getSystemChatHistory/2, getSystemStartCBID/2, getSystemChatbotList/2]).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un sistema.
% Dom: Date (string) X Name (string) X UserList (list) X ChatHistory (list) X
%      StartChatbotID (int) X ChatbotList (list) X System (var)
% M. Primaria: setSystem/7
% M. Secundaria: -
setSystem(Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList, System):-
    System = [Date, Name, UserList, ChatHistory, StartChatbotID, ChatbotList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene la fecha de creacion de un sistema.
% Dom: System (list) X SystemDate (var)
% M. Primaria: getSystemDate/2
% M. Secundaria: setSystem/7
getSystemDate(System, SystemDate):-
    setSystem(SystemDate, _, _, _, _, _, System).

% Descripcion: Obtiene el nombre de un sistema.
% Dom: System (list) X SystemName (var)
% M. Primaria: getSystemName/2
% M. Secundaria: setSystem/7
getSystemName(System, SystemName):-
    setSystem(_, SystemName, _, _, _, _, System).

% Descripcion: Obtiene la lista de usuarios de un sistema.
% Dom: System (list) X SystemUserList (var)
% M. Primaria: getSystemUserList/2
% M. Secundaria: setSystem/7
getSystemUserList(System, SystemUserList):-
    setSystem(_, _, SystemUserList, _, _, _, System).

% Descripcion: Obtiene el historial de un sistema.
% Dom: System (list) X SystemChatHistory (var)
% M. Primaria: getSystemChatHistory/2
% M. Secundaria: setSystem/7
getSystemChatHistory(System, SystemChatHistory):-
    setSystem(_, _, _, SystemChatHistory, _, _, System).

% Descripcion: Obtiene el id del chatbot inicial de un sistema.
% Dom: System (list) X SystemStartCBID (var)
% M. Primaria: getSystemStartCBID/2
% M. Secundaria: setSystem/7
getSystemStartCBID(System, SystemStartCBID):-
    setSystem(_, _, _, _, SystemStartCBID, _, System).

% Descripcion: Obtiene la lista de chatbots de un sistema.
% Dom: System (list) X SystemChatbotList (var)
% M. Primaria: getSystemChatbotList/2
% M. Secundaria: setSystem/7
getSystemChatbotList(System, SystemChatbotList):-
    setSystem(_, _, _, _, _, SystemChatbotList, System).