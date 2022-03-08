close all;
clear;
%% Cargar los datos
datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV

datos2 = load('CochesTest.txt');
ytest = datos2(:,1);  % Precio en Euros
Xtest = datos2(:,2:4); % Años, Km, CV
Ntest = length(ytest);

%% Selección del grado del polinomio para la antigüedad del coche
models=[1 1 1 ; 2 1 1; 3 1 1; 4 1 1; 5 1 1; 6 1 1; 7 1 1; 8 1 1; 9 1 1; 10 1 1];
[w,best_model,RMSEtr,RMSEcv] = kfold_cross_validation(false,Xdatos,ydatos,10,models);

figure;
grid on; hold on;
ylabel('RMSE'); xlabel('Grado polinomio Antigúedad');

plot((1:length(RMSEtr)), RMSEtr, 'r-');
plot((1:length(RMSEcv)), RMSEcv, 'b-');
plot(best_model, RMSEcv(best_model), 'g.');
legend('Error de entrenamiento', 'Error de validación', 'Punto ideal');

%% Selección del grado del polinomio para los kilómetros del coche
models=[5 1 1 ; 5 2 1; 5 3 1; 5 4 1; 5 5 1; 5 6 1; 5 7 1; 5 8 1; 5 9 1; 5 10 1];
[w,best_model,RMSEtr,RMSEcv] = kfold_cross_validation(false,Xdatos,ydatos,10,models);

figure;
grid on; hold on;
ylabel('RMSE'); xlabel('Grado polinomio Kilómetros');

plot((1:length(RMSEtr)), RMSEtr, 'r-');
plot((1:length(RMSEcv)), RMSEcv, 'b-');
plot(best_model, RMSEcv(best_model), 'g.');
legend('Error de entrenamiento', 'Error de validación', 'Punto ideal');

%% Selección del grado del polinomio para la potencia del coche
models=[5 6 1 ; 5 6 2; 5 6 3; 5 6 4; 5 6 5; 5 6 6; 5 6 7; 5 6 8; 5 6 9; 5 6 10];
[w,best_model,RMSEtr,RMSEcv] = kfold_cross_validation(false,Xdatos,ydatos,10,models);

figure;
grid on; hold on;
ylabel('RMSE'); xlabel('Grado polinomio Potencia');

plot((1:length(RMSEtr)), RMSEtr, 'r-');
plot((1:length(RMSEcv)), RMSEcv, 'b-');
plot(best_model, RMSEcv(best_model), 'g.');
legend('Error de entrenamiento', 'Error de validación', 'Punto ideal');

%% Regularización
i = 0.00000001;
lambda = [];
while i < 0.00001
    lambda = [lambda i];
    i = i .* 2;
end

X_exp = expandir(Xdatos,[10 10 10]);
[w,best_model,RMSEtr,RMSEcv] = kfold_cross_validation(true,X_exp,ydatos,10,lambda');

figure;
grid on; hold on;
ylabel('RMSE'); xlabel('Factor de regularización');

plot(lambda, RMSEtr, 'r-');
plot(lambda, RMSEcv, 'b-');
plot(lambda(best_model), RMSEcv(best_model), 'g.');
legend('Error de entrenamiento', 'Error de validación', 'Punto ideal');