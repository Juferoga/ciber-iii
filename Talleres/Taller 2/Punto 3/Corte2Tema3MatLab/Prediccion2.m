%Aplicacion de redes neuronales para la prediccion de una senal ECG

close all
clear all
warning off

%Primero se cargan los datos de la se�al ECG
%load DatosECG
generacionDatos2

ecg_x1=datos(1:999,2)';
ecg_x1=ecg_x1/100;

%Tomando el maximo y el minimo
minino = min(ecg_x1);
maximo = max(ecg_x1);

%Se presentan los datos
plot(ecg_x1)

%Pasando la se�al a simulink
N = length(ecg_x1);
time = 1:N;
ecgData = [time' ecg_x1'];

%Generando los respectivos retardos de la se�al en simulink
sim('Simulacion')

%Para el entrenamiento se toma 70% de datos
Xecg = XECG(1:700,:)';  % Se transpone
Yecg = YECG(1:700,1)';
t=1:700;
plot(t,Yecg)

%Red neuronal feed forward de dos capas metodo de entrenamiento backpropagation
%net = newff([minino maximo;minino maximo;minino maximo],[5 20 1],{'tansig' 'tansig' 'purelin'},'trainlm');
net = newff([minino maximo;minino maximo;minino maximo;minino maximo],[2 2 1],{'tansig' 'tansig' 'purelin'},'trainlm');

%Simulaci�n de la red sin entrenar
y = sim(net,Xecg);
plot(t,Yecg,t,y)
 
%Par�metros de entrenamiento (poca exactitud, error grande)
%net.trainParam.epochs = 100000;
%net.trainParam.goal = 0.0000000000001;

% Mejor precisión, menor error
net.trainParam.epochs = 200000000;
net.trainParam.goal = 0.0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001;

%Entrenamiento de la red
net = train(net,Xecg,Yecg);
     

%Simulaci�n de la red entrenada
y = sim(net,Xecg);
plot(t,Yecg,t,y)

%Comparaci�n con todos los datos
Xecg2 = XECG';
Yecg2 = YECG';
y2 = sim(net,Xecg2);
t2 = 1:length(y2);
plot(t2,Yecg2,'b',t2,y2,'r')

%Figura del error
e = Yecg2-y2;
plot(e)

%Valor del MSE
mse = (1/length(e))*sum(e.^2)
