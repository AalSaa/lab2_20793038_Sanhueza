:- module(tda_user_20793038_SanhuezaVega, [setUser/5, someoneLoggedIn/1, login/4, getUsername/2, getUserCBCodelink/2, getUserFCodelink/2]).

:- use_module(tda_tools_20793038_SanhuezaVega).

% ######################################## CONSTRUCTOR #######################################

% Descripcion: Construye un usuario.
% Dom: Username (string) X Status (int) X CBCodelink (int) X FCodelink (int) X User (var)
setUser(Username, Status, CBCodelink, FCodelink, User):-
    User = [Username, Status, CBCodelink, FCodelink].  

% ######################################## PERTENENCIA #######################################

% Descripcion: Verifica si ya existe un usuario logueado en una lista de usuarios.
% Dom: UserList (list)
someoneLoggedIn([First | _]):-
    getUserStatus(First, UserStatus),
    UserStatus == 1, !.

someoneLoggedIn([_ | Rest]):-
    someoneLoggedIn(Rest).

% ######################################## SELECTOR ##########################################

% Descripcion: Obtiene el nombre de un usuario.
% Dom: User (list) X Username (var)
getUsername(User, Username):-
    setUser(Username, _, _, _, User).

% Descripcion: Obtiene el estado de un usuario.
% Dom: User (list) X UserStatus (var)
getUserStatus(User, UserStatus):-
    setUser(_, UserStatus, _, _, User).

% Descripcion: Obtiene el Chatbot Codelink en el que esta un usuario.
% Dom: User (list) X UserCBCodelink (var)
getUserCBCodelink(User, UserCBCodelink):-
    setUser(_, _, UserCBCodelink, _, User).

% Descripcion: Obtiene el Flow Codelink en el que esta un usuario.
% Dom: User (list) X FlowCodelink (var)
getUserFCodelink(User, UserFCodelink):-
    setUser(_, _, _, UserFCodelink, User).

% ######################################## MODIFICADOR #######################################

% Descripcion: Loguea a un usuario en una lista de usuarios.
% Dom: Username (string) X Userlist (list) X UpdatedUserList (list) X FinalUserList (var)
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