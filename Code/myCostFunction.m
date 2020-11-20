
function J = myCostFunction(X,U,~,data,params)

   % X(1,:)'
    % U(1)
    % data.References
    % params
    % cc
    p=data.PredictionHorizon;
    J_D=0;
    J_U=0;
    J_Y=0;
    k=1;
    y_REF=data.References;
    Y = zeros(8,p);
    u=data.LastMV;
    for i=1:p
         Y(:,i) = pancDTNOUG(X(i,:)',U(i),params);
        J_Y=J_Y+k*(y_REF(i)-Y(1,i)).^2;
        J_U=J_U + (U(i))^2;
        if ( i == 1 )
            J_D=J_D + (U(i)-u).^2;
        else
           J_D=J_D + (U(i)-U(i-1)).^2;    
        end
    end
    k_u=0.01;
    k_y=1;
    k_d=0.01;
    J= k_d*J_D + k_y*J_Y + k_u*J_U;
end
 