% function convertidor_buck()
%     % Parámetros 
%     L = 2e-3;      
%     R = 10;        
%     C = 10e-6;    
%     Uin = 32;     
%     freq = 100e3;  
%     duty = 0.40;   
%     T = 1 / freq;  
% 
%     % Tiempo
%     tspan = [0, 0.005]; 
%     x0 = [0; 0];       
% 
% 
%     options = odeset('MaxStep', T/50);
%     [t, x] = ode45(@(t, x) modelo_convertidor(t, x, L, R, C, Uin, T, duty), tspan, x0, options);
% 
%     % Graficación de resultados
%     figure;
%     subplot(2,1,1);
%     plot(t*1e3, x(:,1), 'b', 'LineWidth', 1.2);
%     title('Corriente en la Inductancia i_L(t)');
%     xlabel('Tiempo (ms)'); ylabel('Corriente (A)'); grid on;
% 
%     subplot(2,1,2);
%     plot(t*1e3, x(:,2), 'r', 'LineWidth', 1.2);
%     title('Voltaje en el Capacitor V_c(t)');
%     xlabel('Tiempo (ms)'); ylabel('Voltaje (V)'); grid on;
% end

% Función del sistema diferencial
function dxdt = modelo_convertidor(t, x, L, R, C, Uin, T, duty)
    % Definición de la señal PWM
    t_mod = mod(t, T);
    if t_mod < duty * T
        d = 1; % Encendido
    else
        d = 0; % Apagado
    end
    % Ecuaciones de estado
    diL = -(1/L)*x(2) + (Uin/L)*d;
    dVc = (1/C)*x(1) - (1/(R*C))*x(2);

    dxdt = [diL; dVc];
end