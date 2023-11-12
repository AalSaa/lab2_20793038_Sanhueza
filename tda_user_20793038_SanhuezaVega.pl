:- module(tda_user_20793038_SanhuezaVega, [setUser/5, someoneLoggedIn/1, getUsername/2, getUserCBCodelink/2, getUserFCodelink/2, getUserLogged/2, login/4, logout/3, updateLoggedUser/5]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## TDA USER ##########################################

% ######################################## REPRESENTACION ####################################

% Este TDA corresponde a un usuario.
% Dentro se guardara el nombre del usuario y un estado de actividad.

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un usuario.
% Dom: Username (string) X Status (int) X CBCodelink (int) X FCodelink (int)
% Rec: User (list)
% Metodo: -
setUser(Username, Status, CBCodelink, FCodelink, User):-
    User = [Username, Status, CBCodelink, FCodelink].  

% ######################################## PERTENENCIA #######################################

% Descripcion: Verifica si ya existe un usuario logueado en una lista de usuarios.
% Dom: UserList (list)
% Rec: -
% Metodo: Recursion
someoneLoggedIn([First | _]):-
    getUserStatus(First, UserStatus),
    UserStatus == 1, !.

someoneLoggedIn([_ | Rest]):-
    someoneLoggedIn(Rest).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el nombre de un usuario.
% Dom: User (list)
% Rec: Username (string)
% Metodo: -
getUsername(User, Username):-
    setUser(Username, _, _, _, User).

% Descripcion: Obtiene el estado de un usuario.
% Dom: User (list)
% Rec: UserStatus (int)
% Metodo: -
getUserStatus(User, UserStatus):-
    setUser(_, UserStatus, _, _, User).

% Descripcion: Obtiene el Chatbot Codelink en el que esta un usuario.
% Dom: User (list)
% Rec: UserCBCodelink (int)
% Metodo: -
getUserCBCodelink(User, UserCBCodelink):-
    setUser(_, _, UserCBCodelink, _, User).

% Descripcion: Obtiene el Flow Codelink en el que esta un usuario.
% Dom: User (list)
% Rec: FlowCodelink (int)
% Metodo: -
getUserFCodelink(User, UserFCodelink):-
    setUser(_, _, _, UserFCodelink, User).

% Descripcion: Obtiene el usuario logueado en una lista de usuarios.
% Dom: Userlist (list)
% Rec: UserLogged (list)
% Metodo: Recursion
getUserLogged([First | _], UserLogged):-
    getUserStatus(First, UserStatus),
    UserStatus == 1,
    UserLogged = First, !.

getUserLogged([_ | Rest], UserLogged):-
    getUserLogged(Rest, UserLogged).

% ######################################## MODIFICADOR #######################################

% Descripcion: Loguea a un usuario en una lista de usuarios.
% Dom: Username (string) X Userlist (list) X UpdatedUserList (list)
% Rec: FinalUserList (list)
% Metodo: Recursion
login(_, [], UpdatedUserList, FinalUserList):-
    FinalUserList = UpdatedUserList, !.

login(Username, [First | Rest], UpdatedUserListA, FinalUserList):-
    getUsername(First, SelectedUsername),
    SelectedUsername == Username,
    setUser(Username, 1, -1, -1, UpdatedUser),
    append(UpdatedUserListA, [UpdatedUser], UpdatedUserListB),
    login(Username, Rest, UpdatedUserListB, FinalUserList), !.

login(Username, [First | Rest], UpdatedUserListA, FinalUserList):-
    append(UpdatedUserListA, [First], UpdatedUserListB),
    login(Username, Rest, UpdatedUserListB, FinalUserList).

% Descripcion: Desloguea a un usuario en una lista de usuarios.
% Dom: Userlist (list) X UpdatedUserList (list)
% Rec: FinalUserlist (list)
% Metodo: Recursion
logout([], UpdatedUserList, FinalUserList):-
    FinalUserList = UpdatedUserList, !.

logout([First | Rest], UpdatedUserListA, FinalUserList):-
    getUsername(First, SelectedUsername),
    setUser(SelectedUsername, 0, -1, -1, UpdatedUser),
    append(UpdatedUserListA, [UpdatedUser], UpdatedUserListB),
    logout(Rest, UpdatedUserListB, FinalUserList).

% Descripcion: Actualiza el cb y f codelink del usuario logueado.
% Dom: NCBCodelink (int) X NFColdelink (int) X Userlist (list) X
%      UpdatedUserList (list)
% Rec: NewUserList (list)
% Metodo: Recursion
updateLoggedUser(_, _, [], UpdatedUserList, FinalUserList):-
    FinalUserList = UpdatedUserList, !.

updateLoggedUser(NCBCodelink, NFColdelink, [First | Rest], UpdatedUserListA, FinalUserList):-
    getUserStatus(First, UserStatus),
    UserStatus == 1,
    getUsername(First, Username),
    setUser(Username, 1, NCBCodelink, NFColdelink, UpdatedUser),
    append(UpdatedUserListA, [UpdatedUser], UpdatedUserListB),
    updateLoggedUser(NCBCodelink, NFColdelink, Rest, UpdatedUserListB, FinalUserList), !.

updateLoggedUser(NCBCodelink, NFColdelink, [First | Rest], UpdatedUserListA, FinalUserList):-
    append(UpdatedUserListA, [First], UpdatedUserListB),
    updateLoggedUser(NCBCodelink, NFColdelink, Rest, UpdatedUserListB, FinalUserList).