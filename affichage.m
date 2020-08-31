function [] = affichage(t,q1,q2)
% Chargement données profil aile
load('Profil_aile.mat');
% Positionnement origine du profil = axe torsion
NACA_6409(:,1) = NACA_6409(:,1) - 0.4; %#ok<NODEF>
NACA_6409(:,2) = NACA_6409(:,2) - 0.06;

D = 20*((2*pi)/360);
L = 1.0;
theta = D*q2;
y = D*L*q1;
%
for k=1:1:length(t)
    
    % Position courante du profil f(theta;y):
    Mat_rot = [cos(theta(k)) sin(theta(k));-sin(theta(k)) cos(theta(k))];
    NACA_courant = NACA_6409*Mat_rot'+ [zeros(length(NACA_6409(:,2)),1) y(k)*ones(length(NACA_6409(:,2)),1)];
    crank = line(NACA_courant(:,1),NACA_courant(:,2),'Color','blue','LineWidth',2); %#ok<NODEF>  
    % Options d'affichage:
    title('\fontsize{14} Coupled-mode flutter : NACA 6409 profile');
    axis(gca,'equal');
    axis([-2.0 2.0 -1.5 1.5]);
    pause(0.03);
    delete(crank);
    
end


end