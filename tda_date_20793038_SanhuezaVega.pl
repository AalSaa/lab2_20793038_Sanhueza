:- module(tda_date, [getDate/1]).

% Descripcion: Obtiene la fecha actual en UNIX.
% Dom: Date (var)
% M. Primaria: getDate/1
% M. Secundaria: get_time/1
getDate(Date):-
    get_time(Date).