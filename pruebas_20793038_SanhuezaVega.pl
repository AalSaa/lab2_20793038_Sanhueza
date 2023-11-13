:- use_module(main_20793038_SanhuezaVega).

% Script de prueba Enunciado 1
/*
option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
option(3, "3) Comer", 3, 1, ["comer", "aprender"], OP3),
flow(1, "flujo1", [OP1, OP2], F10),
flowAddOption(F10, OP3, F11),
% flowAddOption(F10, OP2, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddUser(S0, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10).
*/

% Script de prueba Enunciado 2
/*
option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
% flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10),
systemTalkRec(S10, "hola", S11),
systemTalkRec(S11, "1", S12),
systemTalkRec(S12, "1", S13),
systemTalkRec(S13, "Museo", S14),
systemTalkRec(S14, "1", S15),
systemTalkRec(S15, "3", S16),
systemTalkRec(S16, "5", S17),
systemSynthesis(S17, "user2", Str1).
*/

% Script de prueba Compañia telefonica
/*
option(1, "1) Equipos", 1, 1, ["Equipos", "TELEFONO", "celular"], Op1),
option(2, "2) cambio de PLAN", 2, 1, ["cambio de PLAN", "plan", "cambio", "actualizar"], Op2),
option(3, "3) serviCIO tecniCo", 3, 1, ["serviCIO tecniCo", "servicio", "tecnico"], Op3),
option(4, "4) PORTABILIDAD", 4, 1, ["portar", "PORTABILIDAD"], Op4),
flow(1, "Flujo 1 Chatbot0\n¿Qué te gustaría realizar?", [Op1], F1),
flowAddOption(F1, Op2, F2),
flowAddOption(F2, Op3, F3),
flowAddOption(F3, Op4, F4),
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría realizar?", 1, [F4], Cb0),
option(1, "1) Comprar", 1, 2, ["comprar", "obtener", "adquirir"], Op5),
option(2, "2) renoVAR", 1, 3, ["cambiar", "actualizar", "renovar"], Op6),
option(3, "3) Volver", 0, 1, ["volver", "retroceder", "inicio"], Op7),
flow(1, "Flujo 1 Chatbot1\n¿Qué te gustaría solicitar?", [Op5, Op6, Op7], F5),
chatbot(1, "EQUIPOS", "Bienvenido\n¿Qué te gustaría SOLICITAR?", 1, [], Cb1),
chatbotAddFlow(Cb1, F5, Cb2),
% chatbotAddFlow(Cb2, F5, Cb3), %si se descomenta eso, el programa deberia dar false ya que habria un flow duplicado
option(1, "1) Plan mas economico", 2, 2, ["Plan mas economico", "economico", "barato", "basico"], Op8),
option(2, "2) Plan mas avanzado", 2, 3, ["Plan mas avanzado", "avanzado", "mejorado", "mejor"], Op9),
option(3, "3) vOLVER", 0, 1, ["volver", "retroceder", "INICIO"], Op10),
flow(1, "Flujo 1 Chatbot2\n¿Qué PLAN te gustaría solicitar?", [Op8, Op9, Op10], F6),
chatbot(2, "CAMBIO DE PLAN", "Bienvenido\n¿Qué PLAN te gustaría SOLICITAR?", 1, [F6], Cb4),
option(1, "1) Solicitar reparacion por fallos", 3, 2, ["Solicitar reparacion por fallos", "fallos", "error", "FABRICA"], Op11),
option(2, "2) Solicitar reparacion por daños", 3, 3, ["daños", "roto", "quebrado", "Solicitar reparacion por daños"], Op12),
option(3, "3) vOLVER", 0, 1, ["volver", "retroceder", "INICIO"], Op13),
flow(1, "Flujo 1 Chatbot2\n¿Qué REPARACION NECESITA?", [Op11, Op12], F7),
flowAddOption(F7, Op13, F8),
chatbot(3, "SERVICIO TECNICO", "Bienvenido\n¿Qué REPARACION NECESITA?", 1, [F8], Cb5),
option(1, "1) Portabilidad de otra compañia", 4, 2, ["OTRA", "DIFERENTE", "distinta", "Portabilidad de otra compañia"], Op14),
option(2, "2) Portabilidad de esta misma compañia", 2, 1, ["Portabilidad de esta misma compañia", "MISMA", "IguaL", "ESTA"], Op15),
option(3, "3) vOLVER", 0, 1, ["VOLVER", "retroceder", "inicio"], Op16),
flow(1, "Flujo 1 Chatbot2\n¿Qué portabilidad desea solicitar?", [], F9),
flowAddOption(F9, Op16, F10),
flowAddOption(F10, Op15, F11),
flowAddOption(F11, Op14, F12),
chatbot(4, "portabilidad", "Bienvenido\n¿Qué portabilidad necesita?", 1, [], Cb6),
chatbotAddFlow(Cb6, F12, Cb7),
system("telefonia", 0, [Cb0, Cb2, Cb4, Cb5, Cb7], S0),
% system("telefonica", 0, [Cb0, Cb2, Cb0, Cb2, Cb0, Cb2, Cb0, Cb2, Cb4, Cb5, Cb7], S1), %si se descomenta dara false por chatbots repetidos
system("telefonica", 0, [], S2),
systemAddChatbot(S2, Cb0, S3),
systemAddChatbot(S3, Cb2, S4),
systemAddChatbot(S4, Cb4, S5),
systemAddChatbot(S5, Cb5, S6),
systemAddChatbot(S6, Cb7, S7),
systemAddUser(S7, "USER1", S8),
systemAddUser(S8, "user2", S9),
%systemAddUser(S9, "user1", S10), %si se descomenta esto dara false ya que se intenta agregar un usuario ya existente
%systemLogin(S9, "user777", S11), %si se descomenta esto dara false ya que se intenta loguear un usuario no existente
systemLogin(S9, "user2", S12),
%systemLogin(S12, "user1", S13), %si se descomenta esto dara false ya que se intenta loguear a un usuario cuando ya hay uno logueado.
systemLogout(S12, S14),
systemLogin(S14, "USER1", S15),
systemTalkRec(S15, "1", S16),
systemTalkRec(S16, "3", S17),
systemTalkRec(S17, "2", S18),
systemLogout(S18, S19),
%systemTalkRec(S19, "3", S20), %si se descomenta esto dara false ya que se intenta interactuar con el usuario sin un usuario logueado.
systemLogin(S19, "user2", S21),
systemTalkRec(S21, "servicio tecnico", S22),
systemTalkRec(S22, "VOLVER", S23),
systemTalkRec(S23, "PORTAr", S24),
systemTalkRec(S24, "9", S25),
systemTalkRec(S25, "2", S26),
systemLogout(S26, S27),
%systemSynthesis(S27, "User777", Str1), %si se descomenta esto dara false ya que se intenta sacar el registro de un usuario que no existe.
systemSynthesis(S27, "User2", Str1),
write(Str1).
*/