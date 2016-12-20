function C=Detectar(k,lista,trainPath)
%Treshold-0.4 
%Funcion que detecta las góndolas de la imagen k-ésima, y 
%calcula la metrica respecto al GroundTruth
    I=imread(strcat(trainPath,lista{2*k}));
    Ground=imread(strcat(trainPath,lista{2*k-1}));
    Ground=not(im2bw(Ground,0.4));
    I = imresize(I,1);
    Ig=rgb2gray(I);
    Ir = histeq(Ig);
    Ibin = im2bw(Ir,0.4);
    BW2 = edge(Ir,'Canny',0.5,4.4);
    [H,theta,rho] = hough(BW2);
    H(:,30:150)=0;
    P = houghpeaks(H,6,'threshold',ceil(0.42*max(H(:))));
    lines = houghlines(Ir,theta,rho,P,'FillGap',250,'MinLength',200);
    Pintada=paint(Ir,lines);
    figure; imshowpair(Ground,Pintada,'montage')
    %mostrar='El porcentaje de matching es de ';
    C=Metrica(Pintada,Ground);
end