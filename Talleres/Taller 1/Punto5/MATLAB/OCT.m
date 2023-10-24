close all
clear all
warning('off')

% Sistema
a = newfis('Retinopatía diabética');

% Variable de entrada : Thickness
a=addvar(a,'input','T',[0 2]);  % Rango de espesor

% Funciones de pertenencia
a=addmf(a,'input',1,'cero','gaussmf',[0.7 0.2]);
a=addmf(a,'input',1,'grande','gaussmf',[0.7 1.8]);

% Variable de entrada : Cyst
a=addvar(a,'input','Q',[0 3]);  % Quistes metarretineanos

% Funciones de pertenencia
a=addmf(a,'input',2,'absent','gaussmf',[0.2 0]);
a=addmf(a,'input',2,'mild','gaussmf',[0.2 1]);
a=addmf(a,'input',2,'moderate','gaussmf',[0.2 2]);
a=addmf(a,'input',2,'severe','gaussmf',[0.2 3]);

% Variable de entrada : EZ
a=addvar(a,'input','EZ',[0 2]);  % Elipsoides

% Funciones de pertenencia
a=addmf(a,'input',3,'e_intact','gaussmf',[0.2 0]);
a=addmf(a,'input',3,'e_disrupted','gaussmf',[0.2 1]);
a=addmf(a,'input',3,'e_absent','gaussmf',[0.2 2]);

% Variable de entrada : DRIL
a=addvar(a,'input','DRIL',[0 2]);  % Desorganización de las capas de la retina

% Funciones de pertenencia
a=addmf(a,'input',4,'without','gaussmf',[0.7 0.2]);
a=addmf(a,'input',4,'with','gaussmf',[0.7 1.8]);

% Variable de salida : Retinopatía diabética
a=addvar(a,'output','nivel de retinopatia',[0 4]);

% Funciones de pertenencia
a=addmf(a,'output',1,'Temprana','trimf',[0 0.5 1]);
a=addmf(a,'output',1,'Avanzada','trimf',[1 1.5 2]);
a=addmf(a,'output',1,'Severa','trimf',[2 2.5 3]);
a=addmf(a,'output',1,'Atrófica','trimf',[3 3.5 4]);

% Reglas de inferencia
% [T Q E D] -> [nivel de retinopatia]
ruleList = [
    1 1 1 1 1 1 1  % Temprana
    1 2 1 1 2 1 1  % Avanzada
    2 2 1 2 3 1 1  % Severa
    2 3 2 2 4 1 1  % Atrófica
];

a = addRule(a,ruleList);

% Sistema difuso

fuzzy(a)

% Evaluar el sistema [T, Q, Ez, DRIL]
Y = evalfis([0 3 0 0], a)
