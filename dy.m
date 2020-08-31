function ypoint = dy(y,K,invM,dim_mat)

% Vecteur inconnu y de la forme : 
% 
%	    {Vitesse     : y1    } dimension (dim_mat x 1)
%	y = {Déplacement : y2    } dimension (dim_mat x 1)

  % Définition force :
  
  Dy1 =  -invM*K*y(dim_mat+1:2*dim_mat);
  Dy2 = y(1:dim_mat);
 
  ypoint = [Dy1;Dy2];
  
 %disp(strcat(['TIME:',num2str(t),'s']));
 
end
