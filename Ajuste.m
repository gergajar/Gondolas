%Carpetas con los datos de entrenamiento
clear all
close all
trainPath='./db_entrenamiento_conMask/';
nombres = dir(trainPath);
nombres = {nombres.name};
lista = cell(1,length(nombres)-2);
j = 1;
for i = 3:length(nombres)
    nombre = nombres{i};
    lista{j} = nombre;
    j = j+1;
end
save('lista.mat','lista');
%I=imread(strcat(trainPath,lista{17}));
%I=imread(strcat(trainPath,lista{15}));
for(n=3:3)
    I=imread(strcat(trainPath,lista{2*n}));
    Ground=imread(strcat(trainPath,lista{2*n-1}));
    Ground=not(im2bw(Ground,0.4));
    %Ir = imresize(I,0.25);
    I = imresize(I,1);
    Ig=rgb2gray(I);
    Ir = histeq(Ig);
    %figure
    %imshowpair(Ig,Ir,'montage')
    Ibin = im2bw(Ir,0.4);
    BW2 = edge(Ir,'Canny',0.5,4.4);
    figure;
    imshow(BW2);
    [H,theta,rho] = hough(BW2);
    H(:,30:150)=0;
    P = houghpeaks(H,6,'threshold',ceil(0.42*max(H(:))));
    lines = houghlines(Ir,theta,rho,P,'FillGap',250,'MinLength',200);
    %figure, imshow(Ir), hold on
    A=paint(Ir,lines);
    figure; imshowpair(Ir,A,'montage')
    mostrar='El porcentaje de matching es de ';
    m(n)=Metrica(A,Ground);
    disp(n);
end
disp(mostrar);disp(m);
