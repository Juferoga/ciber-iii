%Aplicación empleando ANFIS para el modelado de un sistema dinámico

close all
clear all
warning off

%Simulación del sistema
sim('ModeloSistemaR16.mdl')

%Sistema de inferencia TSK
in_fis  = genfis1(datos,[4 3 4],char('gbellmf','pimf','trimf'),'linear');

%Épocas de entrenamiento
epoch_n = 100;

%Entrenamiento
out_fis = anfis(datos,in_fis,epoch_n);

%Resultado de la simulación
ys=evalfis(datos(:,1:3),out_fis);

%Salida real del sistema
yr=datos(:,4);

%Presentación de resultados
hold on
plot(ys,'r.-');
plot(yr,'b');
hold off
axis([0 200 0 1.2])
xlabel('Tiempo')
ylabel('y(t)')
title('Resultado simulación')

%Figura del error
e = yr-ys;
figure
plot(e)
xlabel('Tiempo')
ylabel('e(t)')
title('Error')

%Índice de desempeño MSE
mse = 1/length(ys)*sum((yr-ys).^2)
