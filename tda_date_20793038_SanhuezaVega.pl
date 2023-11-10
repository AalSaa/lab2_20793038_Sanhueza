:- module(tda_date, [getDate/1]).

% Descripcion: Obtiene la fecha actual en UNIX.
% Dom: Date (var)
getDate(Date):-
    get_time(Date).