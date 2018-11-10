clc
clear all
close all

%% input system parameters
global Rw Lw Tm M bt R Gr Cr g Cd rho Af n

Rw = 0.3; %Ohms
Lw = 0.015; %Henrys
Tm = 1.718; %Webers
M = 2200; %kg, vehicle mass
bt = 0.05; %Nms/rad
R = 0.2; %m, wheel radius
Gr = 5; %:1 gear ratio
Cr = 0.006; %rolling resistance coefficient
g = 9.81; %m/s^2 
Cd = 0.32; %drag coefficient
rho = 1.21; %kg/m^3, air density
Af = 2.05; %m^2 vehicle frontal area
n = 0.0001; 

vi = 20; %m/s initial vehicle speed
p_3in = ;
p_9in = ;



%% Run ODE45 Solver 

% define initial conditions
initial = [p_3in p_9in]; 

% setup time array
tspan = linspace(0,5,1989); 

% call ODE solver
[t, s] = ode45(@lab4_eqns,tspan,initial);

% pre-allocate additional output vectors
ext = zeros(length(t),2);
ds = zeros(length(t),2);

% obtain actual function outputs
for i = 1:length(t)    
    [ds(i,:) ext(i,:)] = lab3_eqns(t(i), s(i,:));
end

%% max bump height
max_bump =  max(s(:,3)-qsfIN);
const = max_bump/A;
Amax = 0.1/const;

%% Plot Figures

figure('Name','Suspension Displacement','NumberTitle','off','Color','white')
plot(t,s(:,3)-qsfIN,'k',t,s(:,4)-qsrIN,'r'), grid on
title('Suspension Displacement, Forward Configuration')
legend('Front Wheel','Back Wheel')
ylabel('Amplitude (m)')
xlabel('time (s)')

figure('Name','Pitch Angular Velocity','NumberTitle','off','Color','white')
plot(t,s(:,1)./jcr,'k'), grid on
title('Pitch Angular Velocity, Forward Configuration')
legend('Pitch angular velocity')
ylabel('Angular velocity (rad/s)')
xlabel('time (s)')

figure('Name','Heave Velocity','NumberTitle','off','Color','white')
plot(t,s(:,2)./mcr,'k'), grid on
title('Heave Velocity, Forward Configuration')
legend('Heave velocity')
ylabel('Heave velocity (m/s)')
xlabel('time (s)')

