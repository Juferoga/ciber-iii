function f = ControladorT(e)
% Función que implementa el controlador Booleano 
% Taller 1 - Punto 2
% Controlador booleano con retroalimentacion del error
 
% Error positivo A (epa)

if (e < 2) && (e > 4)
    erPosA = 0;
else
    erPosA = 1;
end

% Error positivo B (epb)

if (e < 0) &&  (e > 2)
    erPosB = 0;
else
    erPosB = 1;
end

% Error negativo B (enb)

if (e < -2) && (e > 0)
    erNegB = 0;
else
    erNegB = 1;
end

% Error negativo A (ena)

if (e < -4) && (e > -2)
    erNegA = 0;
else
    erNegA= 1;
end

% Ecuaciones

Y1=erNegA;
Y2=erNegB;
Y3=0;
Y4=erPosB;
Y5=erPosA;

% Actuadores

Ung = 5;
Unp = 0;
Uz  = 100;
Upp = 5;
Upg = 0;

% Salida

f = Ung*Y1 + Unp*Y2 + Uz*Y3 + Upp*Y4 + Upg*Y5;
