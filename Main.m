%Carpetas con los datos de entrenamiento
close all
%Carpetas con los datos de entrenamiento
trainPath='./db_entrenamiento_+mascaras/';
nombres = dir(trainPath);
nombres = {nombres.name};
lista = cell(1,length(nombres)-2);
j = 1;
%Inserte un nuemero del 1 al 20
n=18;
for i = 3:length(nombres)
    nombre = nombres{i};
    lista{j} = nombre;
    j = j+1;
end
%Leer las imágenes de la dirección señalada, y su ground
I=imread(strcat(trainPath,lista{2*n}));
Ground=imread(strcat(trainPath,lista{2*n-1}));
Ground=not(im2bw(Ground,0.4));
treshold=0.42;sigma=4.4;trcanny=0.5;
%Detectar la gondola y pintar la imagen n
Pintada=Detectar(n,lista,trainPath);
%Comparar la imagen pintada con el Ground, puede usarse con cualquier
%Par de Imagenes
C=Metrica(Pintada,Ground);
s='La metrica entrega un valor de matching de  ';
disp(s);
disp(C);

