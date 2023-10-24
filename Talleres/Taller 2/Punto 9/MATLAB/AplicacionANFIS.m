%Aplicación empleando ANFIS predicción de series de tiempo

%Serie de tiempo Mackey-Glass 
%dx(t)/dt = 0.2x(t-tau)/(1+x(t-tau)^10) - 0.1x(t)
%Sistema caótico x(0) = 1.2 y tau = 17
%se considera x(t) = 0 cuando t < 0.

close all
clear all
warning off

%Cargar la serie de tiempo
load serie.mat

%Tomando los datos
a=X;
time = a(:, 1);
ts = a(:, 2);
plot(time, ts);
xlabel('Tiempo (sec)'); ylabel('x(t)');
title('Serie de tiempo');

%Datos de entrenamiento y de comprobación
%Se emplean 500 datos de entrenamiento
%La predicción se realiza mediante 4 muestras de entrada y 1 salida
trn_data = zeros(50, 5);
chk_data = zeros(50, 5);

%Datos de entrenamiento
START = 6;
start = START - 4;
trn_data(:, 1) = ts(start:start+50-1);
start = START - 3;
trn_data(:, 2) = ts(start:start+50-1);
start = START - 2;
trn_data(:, 3) = ts(start:start+50-1);
start = START - 1;
trn_data(:, 4) = ts(start:start+50-1);
start = START - 0;
trn_data(:, 5) = ts(start:start+50-1);

%Datos de chequeo
START = 52;
start = START - 4;
chk_data(:, 1) = ts(start:start+50-1);
start = START - 3;
chk_data(:, 2) = ts(start:start+50-1);
start = START - 2;
chk_data(:, 3) = ts(start:start+50-1);
start = START - 1;
chk_data(:, 4) = ts(start:start+50-1);
start = START - 0;
chk_data(:, 5) = ts(start:start+50-1);

%Gráfica de los datos de entrenamiento y de comprobación
index = 1:100;
figure
plot(time(index), ts(index));
axis([min(time(index)) max(time(index)) min(ts(index)) max(ts(index))]);
xlabel('Time (sec)'); ylabel('x(t)');
title('Mackey-Glass serie de tiempo caótica');

%Generación del sistema difuso a emplear
fismat = genfis1(trn_data,[4 4 4 4],char('gbellmf','gbellmf','gbellmf','gbellmf'));

%Presentación de las funciones de pertenencía empleadas
figure
for input_index=1:4
    subplot(2,2,input_index)
    [x,y]=plotmf(fismat,'input',input_index);
    plot(x,y)
    axis([-inf inf 0 1.2]);
    xlabel(['Input ' int2str(input_index)]);
end

%Entrenamiento del sistema difuso mediante anfis
[trn_fismat,trn_error] = anfis(trn_data, fismat)

%Presentación de las funciones de pertenencia entrenadas
figure
for input_index=1:4
    subplot(2,2,input_index)
    [x,y]=plotmf(trn_fismat,'input',input_index);
    plot(x,y)
    axis([-inf inf 0 1.2]);
    xlabel(['Input ' int2str(input_index)]);
end

%Simulación del sistema con todos los datos
X = [trn_data(:,1:4);chk_data(:,1:4)];
Y = [trn_data(:,5);chk_data(:,5)];
Ys = evalfis(X,trn_fismat);

%Presentación de resultados
figure
hold on
plot(Y,'r')
plot(Ys,'b')
hold off
xlabel('Tiempo (seg)'); ylabel('x(t)');
title('Mackey-Glass serie de tiempo caótica');
legend('Reales', 'Simulados')

%Figura del error
e = Y - Ys;
min(e)
figure
plot(e)
xlabel('Tiempo (seg)'); ylabel('e(t)');
title('Error');

%Error cuadrático medio
N = length(e);
MSE = (1/N)*sum(e.^2)
