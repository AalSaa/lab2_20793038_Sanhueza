:- module(tda_flow_20793038_SanhuezaVega, [flow/4, flowAddOption/3]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Crea un flujo.
% Dom: ID (int) X NameMSG (string) X Options (list) X Flow (var)
% M. Primaria: flow/4
% M. Secundaria: downcase_atom/2, addElementsInList/3, setFlow/4
flow(ID, NameMSG, Options, Flow):-
    downcase_atom(NameMSG, MinNameMSG),
    addElementsInList(Options, [], OptionList),
    setflow(ID, MinNameMSG, OptionList, Flow).

% Descripcion: Construye un flujo.
% Dom: ID (int) X MinNameMSG (string) X OptionList (list) X Flow (var)
% M. Primaria: setFlow/4
% M. Secundaria: -
setflow(ID, MinNameMSG, OptionList, Flow):-
    Flow = [ID, MinNameMSG, OptionList].

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el id de un flujo.
% Dom: Flow (list) X FlowID (var)
% M. Primaria: getFlowID/2
% M. Secundaria: setFlow/4
getFlowID(Flow, FlowID):-
    setflow(FlowID, _, _, Flow).

% Descripcion: Obtiene el mensaje que contiene el flujo.
% Dom: Flow (list) X FlowNameMSG (var)
% M. Primaria: getFlowNameMSG/2
% M. Secundaria: setFlow/4
getFlowNameMSG(Flow, FlowNameMSG):-
    setflow(_, FlowNameMSG, _, Flow).

% Descripcion: Obtiene la lista de opciones de un flujo.
% Dom: Flow (list) X FlowOptionList (var)
% M. Primaria: getFlowOptionList/2
% M. Secundaria: setflow/4
getFlowOptionList(Flow, FlowOptionList):-
    setflow(_, _, FlowOptionList, Flow).

% ######################################## MODIFICADOR #######################################

% Descripcion: Agrega una opcion a la lista de opciones del flujo.
% Dom: Flow (list) X Option (list) X NewFlow (var)
% M. Primaria: flowAddOption/3
% M. Secundaria: getFlowID/2, getFlowNameMSG/2, getFlowOptionList/2, addElementsInList/3, setFlow/4
flowAddOption(Flow, Option, NewFlow):-
    getFlowID(Flow, ID),
    getFlowNameMSG(Flow, NameMSG),
    getFlowOptionList(Flow, CurrentOptionList),

    addElementsInList([Option], CurrentOptionList, NewOptionList),

    setflow(ID, NameMSG, NewOptionList, NewFlow).