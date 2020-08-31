
%%
%-------------------------------------
% Coupled-mode flutter of an airfoil :
%-------------------------------------

function [w_real,w_imag] = Aero_flutter(Cy)
%%
%------------
% Variables :
%------------
eps = 0.25;
omega = sqrt(0.5);
k = 1.0;
X = 0.25;
% q1 : normalize ddl y for plunge
% q2 : normalize ddl theta for torsion

%%
%------------
% Matrices :
%------------
K = [omega^2 -Cy*2*pi*omega^2/k;
     k*eps (1-Cy*2*pi*(eps+X))];
 
M = [1 -eps;
     0 1];
%%
%-----------------------------
% Calcul pulsations propres : 
%-----------------------------
[V,F] = eig(K,M);
puls_2 = diag(F);
w_real = sqrt(abs(puls_2)).*(cos(angle(puls_2)/2));
w_imag = sqrt(abs(puls_2)).*(sin(angle(puls_2)/2));

end