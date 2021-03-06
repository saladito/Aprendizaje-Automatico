%% Lab 6.2: SVD 

clear all
close all

% use YOUR image!
I = imread('cesar.jpg');

% Convert to B&W
BW = rgb2gray(I);

% Convert data to double
X=im2double(BW);

nrows=size(X,1);
ncols=size(X,2);

% show image
figure(1);
colormap(gray);
imshow(X);
axis off;
pause();

% Apply SVD
[U,S,V] = svd(X);

% % Plot first 5 components
for k = 1:5
    Xhat = zeros(nrows,ncols);
    for i=(1:k)
        Xhat = Xhat + U(:,i)*S(i,i)*V(:,i)';
    end
    figure(2);
    imshow(Xhat);
    colormap(gray);
    axis off;
    pause();
end

clear Xhat
Xhat = zeros(nrows,ncols);
% Plot the image reconstructed with 1, 2, 5, 10, 20, and the total number
% of components

for k = [1 2 5 10 20 rank(X)]
    Xhat = zeros(nrows,ncols);
    for i=(1:k)
        Xhat = Xhat + U(:,i)*S(i,i)*V(:,i)';
    end
    figure(3);
    imshow(Xhat);
    colormap(gray);
    axis off;
    pause();
end

% Find the value of k that maintains 90% of variability
k_escogido = false;
k = 1;
Sv = diag(S);
while k_escogido == false && k <= (nrows*ncols)
    if((sum(Sv(1:k))/sum(Sv)) >= 0.90)
        k_escogido = true;
    else
        k = k+1;
    end
end

% Plot the image reconstructed with the first  k components
Xhat = zeros(nrows,ncols);
for i=(1:k)
    Xhat = Xhat + U(:,i)*S(i,i)*V(:,i)';
end
figure(4);
imshow(Xhat);
colormap(gray);
axis off;

% Compute and show savings in space
original = nrows*ncols;
reduced = (nrows+ncols+1)*29;
fprintf("Componentes de la imagen original = %d\n",original);
fprintf("Componentes tras la reducción con SVD = %d\n",reduced);
fprintf("Espacio ahorrado = %.2f%%\n",((original-reduced)/original)*100);