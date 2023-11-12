:- module(tda_flow_20793038_SanhuezaVega, [setFlow/4, getFlowID/2, getFlowNameMSG/2, getFlowOptionList/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## TDA FLOW ##########################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a un flujo.
% Dentro se guardara un id del flujo, un nombre para el flujo y una lista de opciones.

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un flujo.
% Dom: ID (int) X MinNameMSG (string) X OptionList (list)
% Rec: Flow (list)
% Metodo: -
setFlow(ID, NameMSG, OptionList, Flow):-
    Flow = [ID, NameMSG, OptionList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un flujo.
% Dom: Flow (list)
% Rec: FlowID (int)
% Metodo: -
getFlowID(Flow, FlowID):-
    setFlow(FlowID, _, _, Flow).

% Descripcion: Obtiene el mensaje que contiene el flujo.
% Dom: Flow (list)
% Rec: FlowNameMSG (string)
% Metodo: -
getFlowNameMSG(Flow, FlowNameMSG):-
    setFlow(_, FlowNameMSG, _, Flow).

% Descripcion: Obtiene la lista de opciones de un flujo.
% Dom: Flow (list)
% Rec: FlowOptionList (list)
% Metodo: -
getFlowOptionList(Flow, FlowOptionList):-
    setFlow(_, _, FlowOptionList, Flow).