:- module(tda_flow_20793038_SanhuezaVega, [setFlow/4, getFlowID/2, getFlowNameMSG/2, getFlowOptionList/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un flujo.
% Dom: ID (int) X MinNameMSG (string) X OptionList (list) X Flow (var)
% M. Primaria: setFlow/4
% M. Secundaria: -
setFlow(ID, NameMSG, OptionList, Flow):-
    Flow = [ID, NameMSG, OptionList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un flujo.
% Dom: Flow (list) X FlowID (var)
% M. Primaria: getFlowID/2
% M. Secundaria: setFlow/4
getFlowID(Flow, FlowID):-
    setFlow(FlowID, _, _, Flow).

% Descripcion: Obtiene el mensaje que contiene el flujo.
% Dom: Flow (list) X FlowNameMSG (var)
% M. Primaria: getFlowNameMSG/2
% M. Secundaria: setFlow/4
getFlowNameMSG(Flow, FlowNameMSG):-
    setFlow(_, FlowNameMSG, _, Flow).

% Descripcion: Obtiene la lista de opciones de un flujo.
% Dom: Flow (list) X FlowOptionList (var)
% M. Primaria: getFlowOptionList/2
% M. Secundaria: setflow/4
getFlowOptionList(Flow, FlowOptionList):-
    setFlow(_, _, FlowOptionList, Flow).