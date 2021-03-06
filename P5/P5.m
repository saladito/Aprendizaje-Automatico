clear ; close all;

%% Load Data MNIST
load('MNISTdata2.mat'); % Lee los datos: X, y, Xtest, ytest
rand('state',0);
[Xtr, ytr, Xcv, ycv] = separar(X,y,0.8); %   Separar 20% de los datos para 
                                         % validación
N_pixels = width(Xtr);
N_clases = 10;

%% Bayes ingenuo
lambda = logspace(-6, 2);

[Etr,Ecv,best_lambda] = entrenarYclasificarBayes(Xtr,ytr,Xcv,ycv,N_clases, ...
    lambda,1);

dibujarEvolucionErrores(lambda,best_lambda,Etr,Ecv);

disp(lambda(best_lambda));
%% Matriz de confusión y Precisión/Recall para el modelo de Bayes ingenuo

% Entrenar todos los datos con el mejor modelo

modelo = entrenarGaussianas(X,y,N_clases,1,lambda(best_lambda));
ytest_pred = clasificacionBayesiana(modelo,Xtest);

% Calcular matriz de confusión, precisión y recall
[m,P,R] = confusionMatrix(ytest_pred,ytest,N_clases);

disp(m);
disp(P);
disp(R);

verConfusiones(Xtest, ytest, ytest_pred);

%% Covarianzas completas

[Etr,Ecv,best_lambda] = entrenarYclasificarBayes(Xtr,ytr,Xcv,ycv,N_clases, ...
    lambda,0);

dibujarEvolucionErrores(lambda,best_lambda,Etr,Ecv);

disp(lambda(best_lambda));

%% Matriz de confusión y Precisión/Recall para el modelo de Covarianzas Completas

% Entrenar todos los datos con el mejor modelo

modelo = entrenarGaussianas(X,y,N_clases,0,lambda(best_lambda));
ytest_pred = clasificacionBayesiana(modelo,Xtest);

% Calcular matriz de confusión, precisión y recall
[m,P,R] = confusionMatrix(ytest_pred,ytest,N_clases);

disp(m);
disp(P);
disp(R);

verConfusiones(Xtest, ytest, ytest_pred);