 close all;
%% Double Pendulum System Parameters
gv = 9.81; % Gravity Constant
m1 = 1;    % Mass of bob 1 
m2 = 1;    % Mass of bob 2
L1 = 1;    % Length of Rod 1
L2 = 1/2;  % Length of Rod 2 (Cases: [1/4 1/2] m)

%% Initial Conditions
ICs = [pi/3 0 pi*2/3 0];

%% Time Step 
t_intv = [0 5];
t_step = 500;

%% Integrators

[t_rk,y_rk]   = pend(t_intv,ICs,t_step,m1,m2,L1,L2,gv,'rk');
[t_trp,y_trp] = pend(t_intv,ICs,t_step,m1,m2,L1,L2,gv,'trp');
[t_eul,y_eul] = pend(t_intv,ICs,t_step,m1,m2,L1,L2,gv,'eul');

%% ODE 45 

[t_ode45,y_ode45] = ode45(@(t,y) YDOT(t,y,gv,m1,m2,L1,L2) ,t_intv,ICs);


%% Plot

figure
hold on
pl(1) = plot(t_eul,y_eul(:,1),':','color',"#0072BD",'LineWidth',2);
pl(2) = plot(t_trp,y_trp(:,1),'-.','color',"#D95319",'LineWidth',2);
pl(3) = plot(t_rk,y_rk(:,1),'--','color',"#EDB120",'LineWidth',2);
pl(4) = plot(t_ode45,y_ode45(:,1),'-','Color',"#77AC30",'LineWidth',2);
xlabel ('Time [s]')
ylabel ('\theta_1 [rad]')
lg = legend([pl(1),pl(2),pl(3),pl(4)],{'Euler','Trapezoid','Runge-Kutta','ODE45'});
lg.Location = 'best';
ylim([-1.5 1.5])
grid on
box on 