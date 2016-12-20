function J=paint(I,lines)
    n=length(lines);
    %Se almacenan las coordenadas de las lineas
    for i=1:n
        yleft(i)=lines(i).point1(2);
    end
    index=1;
    dy=zeros(n);
    %Se calculan las distancias verticales
    for j=1:n
        for k=1:n
            if(j>=k)
                dy(j,k)=10000;
            else
            dy(j,k)=abs(yleft(k)-yleft(j));
            end
        end
    end
    %Se calcula la linea mas cercana
    closest=zeros(n,2);
    for j=1:n
        %El mas cercano a j es i, y esta a una distancia c
        [c,i]=min(dy(j,:));
        closest(j,1)=c;
        closest(j,2)=i;
    end
    ind=-1;
    %Almacenamiento de los pares correspondientes
    for j=1:n
        if (closest(j,1)<250)
            ind=ind+2;
            inip{ind}=lines(j).point1;
            finp{ind}=lines(j).point2;
            inip{ind+1}=lines(closest(j,2)).point1;
            finp{ind+1}=lines(closest(j,2)).point2;
        end            
    end 
    l=length(inip);
    for(j=1:l)
        J{1,j}=inip{j};
        J{2,j}=finp{j};
    end
    large=length(J);
    centros=1:2:large;
    rows=zeros(length(centros),4);
    cols=zeros(length(centros),4);
    %Coonversión a matrices con las filas de los vertices
    %Y otra con sus columnas
    for i=1:length(centros)
        c=centros(i);
        %Se verifica que los vertices estén ordenados
        if (J{1,c}(2)<J{1,c+1}(2))
            aux=J{1,c}(2);
            J{1,c}(2)=J{1,c+1}(2);
            J{1,c+1}(2)=aux;
        end
        if (J{2,c}(2)>J{2,c+1}(2))
            aux=J{2,c}(2);
            J{2,c}(2)=J{2,c+1}(2);
            J{2,c+1}(2)=aux;
        end
        rows(i,:)=[J{1,c}(2) J{1,c+1}(2) J{2,c}(2) J{2,c+1}(2)];
        cols(i,:)=[J{1,c}(1) J{1,c+1}(1) J{2,c}(1) J{2,c+1}(1)];
    end
    [a,b]=size(I);
    painted=zeros(a,b,length(centros));
    %Se pinta le poligono por separado
    for i=1:length(centros)
        painted(:,:,i)=roipoly(I,cols(i,:),rows(i,:));
    end
    final=painted(:,:,1);
    %Se pintan todos los poligonos existentes superponiendose
    for i=1:length(centros)
        final=(final|painted(:,:,i));
    end
    J=final;
end