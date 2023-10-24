% Ejercicio del sistema de lógica difusa para control de horno para pan
% implementado en comandos
% Punto 5 Corte 1 ~ 20181020158

close all
clear all
warning('off')

% Sistema
a=newfis('HornoPan');

% Variable de entrada: Temperatura
a=addvar(a,'input','Temperatura',[0 10]);

%Funciones de pertenencia
a=addmf(a,'input',1,'Baja','gaussmf',[1.5 0]);
a=addmf(a,'input',1,'Media','gaussmf',[1.23 5]);
a=addmf(a,'input',1,'Alta','gaussmf',[1.5 10]);
plotmf(a,'input',1)

%Variable de entrada: Tiempo
a=addvar(a,'input','Tiempo',[0 10]);

%Funciones de pertenencia
a=addmf(a,'input',2,'Poco','trapmf',[-10 -10 2 3]);
a=addmf(a,'input',2,'Suficiente','trapmf',[7 8 20 20]);
plotmf(a,'input',2)


% Variable de entrada: Vapor
a=addvar(a,'input','Vapor',[0 10]);

%Funciones de pertenencia
a=addmf(a,'input',3,'Imperceptible','gaussmf',[1.5 0]);
a=addmf(a,'input',3,'Necesario','gaussmf',[1.5 10]);
plotmf(a,'input',3)

%Variable de salida: Calidad del pan
a=addvar(a,'output','CalidadPan',[0 10]);

%Funciones de pertenencia
a=addmf(a,'output',1,'Malo','trimf',[0.0534 1.17 2.337]);
a=addmf(a,'output',1,'Regular','trimf', [1.81 3.07 4.235]);
a=addmf(a,'output',1,'Normal','trimf', [3.72 5.04 6.357]);
a=addmf(a,'output',1,'Bueno','trimf',  [5.95 7.11 8.276]);
a=addmf(a,'output',1,'Excelente','trimf',  [7.827 8.99 9.98]);
plotmf(a,'output',1)

%Reglas de inferencia
ruleList=[
  	1 1 1 1 1 1
    1 2 1 1 1 1
   	2 2 0 1 1 1
    3 2 0 1 1 1
    3 2 2 1 1 1];

a = addRule(a,ruleList);

% Sistema difuso
fuzzy(a)

% Evaluar el sistema [temperatura, tiempo, vapor]
Y = evalfis([1 1 1],a)
