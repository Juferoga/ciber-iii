%Aplicación para el modelamiento de un sistema dinámico con redes neuronales
%Realizando la codificación de los datos en simulink

close all;
clear;
warning off;

%Realizar la simulación del modelo
% Se caracteriza el comportamiento del sistema para 1 valor
sim('/MATLAB Drive/CIBER-III-P2C2/DatosPasoR16.mdl')
disp('Iniciando simulación Simulink...');
%sim('/MATLAB Drive/CIBER-III-P2C2/DatosAleatoriosR16');
disp('Simulación Simulink completada.');

%Lectura de datos de simulink
P=PP';
T=TT';

disp('Dimensiones de PP:');
disp(size(PP));
disp('Dimensiones de TT:');
disp(size(TT));

%Valores máximos y mínimos
MinMax = [min(P')' max(P')'];

%Red neuronal
%net=newff(MinMax,[45 1],{'tansig' 'purelin'});
net=newff(MinMax,[12 12 8 1],{'tansig' 'tansig' 'tansig' 'purelin'});

disp('Propiedades de la red neuronal:');
disp(net);

%Entrenamiento de la red neuronal
net.trainParam.epochs = 500;
net = train(net,P,T);

%Resultado de la red neuronal
Y = sim(net,P);

% Presentación del resultado
t = 1:length(Y);
figure(1);  % Crea una nueva figura
plot(t, T, 'r', t, Y, 'b');
title('Resultados');
xlabel('Tiempo');
ylabel('Valores');
legend('T (objetivo)', 'Y (salida)');

% Figura del error
e = T - Y;
figure(2);  % Crea otra nueva figura
plot(t, e, 'g');
title('Error');
xlabel('Tiempo');
ylabel('Error');

%Valor del MSE
mse = (1/length(e))*sum(e.^2);
disp('Valor del MSE:');
disp(mse);
