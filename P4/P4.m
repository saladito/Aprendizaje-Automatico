clear ; close all;
addpath(genpath('../minfunc'));

%% Load Data MNIST
load('MNISTdata2.mat'); % Lee los datos: X, y, Xtest, ytest
rand('state',0);
[Xtr, ytr, Xcv, ycv] = separar(X,y,0.8); %   Separar 20% de los datos para 
                                         % validación

%% Regresión logística regularizada
Xtr = [ones(height(ytr),1) Xtr];
Xcv = [ones(height(ycv),1) Xcv];
theta = [zeros(size(Xtr,2),1)];

options = [];
options.display = 'final';
options.method = 'newton';
lambda = logspace(-6, 2);

Etr = (zeros(length(lambda),1));
Ecv = (zeros(length(lambda),1));

best_model = 0;
best_errV = inf;

for model = 1:length(lambda)
    etr = 0; ecv = 0;
    for i = 1:10
        y_clasif = (ytr == i);
        th = minFunc(@costeLogReg, zeros(size(Xtr,2),1), options, Xtr, y_clasif, ...
            lambda(model));
        theta = [theta th];
    end
    h = 1./(1+exp(-(Xtr*theta))) >= 0.5;
    etr = etr + tasa_error(h,ytr);

    h = 1./(1+exp(-(Xcv*theta))) >= 0.5;
    ecv = ecv + tasa_error(h,ycv);

    Etr = [Etr;etr];
    Ecv = [Ecv;ecv];

    if ecv < best_errV
        best_errV = ecv;
        best_model = model;
    end
end

for i = 1:10
    y_clasif = (ytr == i);
    th = minFunc(@costeLogReg, zeros(size(Xtr,2),1), options, Xtr, y_clasif, ...
        lambda(best_model));
    theta = [theta th];
end

h = 1./(1+exp(-(Xtr*theta))) >= 0.5;
verConfusiones(Xtr, ytr, h);


