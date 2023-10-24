% Taller 1  Punto 1
function Ft = ControladorT(X)
%Función que implementa el controlador Booleano 

%Sensores
D= X(1);
C= X(2);
B= X(3);
A= X(4);

%Funciones de activación
%F1 = max(min((1-A),(1-B),(1-C),(1-D)),min((1-A),C,D));
%F2 = min((1-A),(1-B));
%F3 = min((1-C),(1-B),(1-A));

% Funciones de activación
F1 = (1-A)*(1-B)*(1-C)*(1-D) + (1-A)*C*D;
F2 = (1-A)*(1-B); 
F3 = (1-C)*(1-B)*(1-A);

%Actuadores
q1 = 0.01;
q2 = 0.01;
q3 = 0.0465;

%Flujo Total
Ft = F1*q1 + F2*q2 + F3*q3;	