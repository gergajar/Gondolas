function M=metrica(I1,I2)
%Funcion que recibe dos mascaras y computa su metrica
num=sum(I1&I2);
den=sum(I1|I2);
M=num/den;
end