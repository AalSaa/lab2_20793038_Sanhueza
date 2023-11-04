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