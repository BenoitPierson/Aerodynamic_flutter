
% Cours Interaction fluide-structure :
% https://fr.coursera.org/lecture/fluid-solid-interaction/4-4-coupled-mode-flutter-of-an-airfoil-jqoXE
 


Omega_R_1 = [];
Omega_I_1 = [];
Omega_R_2 = [];
Omega_I_2 = [];

Cy = 0.0:0.0001:0.15;

for i = 1:1:length(Cy)
   [w_real,w_imag] = Aero_flutter(Cy(i));
  
   Omega_R_1 = [Omega_R_1;w_real(1)]; %#ok<AGROW>
   Omega_I_1 = [Omega_I_1;w_imag(1)]; %#ok<AGROW>
   
   Omega_R_2 = [Omega_R_2;w_real(2)]; %#ok<AGROW>
   Omega_I_2 = [Omega_I_2;w_imag(2)]; %#ok<AGROW>  
   
end

%% PLOT
%
% figure;
% subplot(2,1,1);
% plot(Cy,Omega_R_1,Cy,Omega_R_2);
% xlabel('\fontsize{14}C_{y}');
% ylabel('\fontsize{14}\omega_{real}');
% legend('\fontsize{12}Damped mode','\fontsize{12}Unstable mode');
% subplot(2,1,2);
% plot(Cy,Omega_I_1,Cy,Omega_I_2);
% xlabel('\fontsize{14}C_{y}');
% ylabel('\fontsize{14}\omega_{imaginary}');
% legend('\fontsize{12}Damped mode','\fontsize{12}Unstable mode');

%% ANIMATED PLOT
%
% curve1 = animatedline('Color','r');
% curve2 = animatedline('Color','b');
% curve3 = animatedline('Color','r');
% curve4 = animatedline('Color','b');
% 
% set(gca,'XLim',[0 0.15],'YLim',[0.4 1.2]);
% grid on;
% 
% for k=1:length(Cy)
%    addpoints(curve1,Cy(k),Omega_R_1(k));
%    addpoints(curve2,Cy(k),Omega_R_2(k));
%    xlabel('\fontsize{14}C_{y}');
%    ylabel('\fontsize{14}\omega_{real}');
%    drawnow 
% end
% 
% set(gca,'XLim',[0 0.15],'YLim',[-0.4 0.4]);
% grid on;
% 
% for k=1:length(Cy)
%    addpoints(curve3,Cy(k),Omega_I_1(k));
%    addpoints(curve4,Cy(k),Omega_I_2(k));
%    xlabel('\fontsize{14}C_{y}');
%    ylabel('\fontsize{14}\omega_{imaginary}');
%    drawnow 
% end

%% INTEGRATION TEMPORELLE
V_init = zeros(2,1);
U_init = [0.005;0.0];% Perturbation 
t1 = 0.0;
t2 = 60.0;
%
eps = 0.25;
omega = sqrt(0.5);
k = 1.0;
X = 0.25;
Cy = 0.1;
% q1 : normalize ddl y for plunge
% q2 : normalize ddl theta for torsion
K = [omega^2 -Cy*2*pi*omega^2/k;k*eps (1-Cy*2*pi*(eps+X))];
M = [1 -eps;0 1];
invM = inv(M);
dim_mat = 2;
%
[t,y] = ode45(@(t,y) dy(y,K,invM,dim_mat),[t1 t2],[V_init; U_init]);
%

 figure;
 curve5 = animatedline('Color','r');
 %curve6 = animatedline('Color','b');
 
 set(gca,'XLim',[-1.5 1.5],'YLim',[-2.5 2.5]);
 
 for k=1:length(t)
    addpoints(curve5,y(k,3),y(k,4));
    xlabel('\fontsize{14}q_{1} = y / (DL)');
    ylabel('\fontsize{14}q_{2} = \theta / D');
    drawnow 
 end
 
 %%
% AFFICHAGE MOUVEMENT PROFIL AILE NACA 6409
 figure;
 affichage(t,y(:,3),y(:,4));















