:- module(tda_date, [getDate/1]).

% ######################################## TDA DATE ##########################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a una fecha.
% dentro de ella se incluye la fecha en formato UNIX.

% Descripcion: Obtiene la fecha actual en UNIX.
% Dom: -
% Rec: Date (string)
% Metodo: -
getDate(Date):-
    get_time(Date).