:- module(tda_flow_20793038_SanhuezaVega, [setFlow/4, getFlowID/2, getFlowNameMSG/2, getFlowOptionList/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un flujo.
% Dom: ID (int) X MinNameMSG (string) X OptionList (list) X Flow (var)
setFlow(ID, NameMSG, OptionList, Flow):-
    Flow = [ID, NameMSG, OptionList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un flujo.
% Dom: Flow (list) X FlowID (var)
getFlowID(Flow, FlowID):-
    setFlow(FlowID, _, _, Flow).

% Descripcion: Obtiene el mensaje que contiene el flujo.
% Dom: Flow (list) X FlowNameMSG (var)
getFlowNameMSG(Flow, FlowNameMSG):-
    setFlow(_, FlowNameMSG, _, Flow).

% Descripcion: Obtiene la lista de opciones de un flujo.
% Dom: Flow (list) X FlowOptionList (var)
getFlowOptionList(Flow, FlowOptionList):-
    setFlow(_, _, FlowOptionList, Flow).