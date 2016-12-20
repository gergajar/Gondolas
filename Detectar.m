function C=Detectar(k,lista,trainPath)
%Funcion que detecta las góndolas de la imagen k-ésima 
    I=imread(strcat(trainPath,lista{2*k}));
    Ground=imread(strcat(trainPath,lista{2*k-1}));
    Ground=not(im2bw(Ground,0.4));
    Ig=rgb2gray(I);
    Ir = histeq(Ig);
    %Detector de bordes Canny
    BW2 = edge(Ir,'Canny',0.5,4.4);
    %Transformada de Hough
    [H,theta,rho] = hough(BW2);
    %Se eliminan los angulos que no se quieren detectar como peaks
    H(:,30:150)=0;
    %Deteccion de Peaks
    P = houghpeaks(H,6,'threshold',ceil(0.42*max(H(:))));
    %Extraccion de lineas de los peaks
    lines = houghlines(Ir,theta,rho,P,'FillGap',250,'MinLength',200);
    %Metodo usado para pintar la imagen 
    Pintada=paint(Ir,lines);
    %Mostrar ambas imagenes
    figure; imshowpair(Ground,Pintada,'montage')
    C=Pintada;
end