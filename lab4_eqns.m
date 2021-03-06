% state derivative function
function [ds, ext] = lab4_eqns(t,s);

% input system parameters
global Rw Lw Tm M bt R Gr Cr g Cd rho Af n vi uinss Fb im p_in

% renaming variables for clarity
p_3 = s(1); %momentum to inductor
p_9 = s(2); %momentum to car mass

% define u_in and Fb time
T1=0.5;
T2=2;

% defining uin and Fb and v
if t < T1;
	u_in = uinss; %initial voltage
    fb=0;
    %v=vi; %initial velocity
elseif t >= T1 && t <= T2;
	u_in = uinss.*(1-2/3.*(t-0.5)); %ramp down
    fb=Fb;
    %v=vi.*(1-2/3.*(t-0.5));
else t > T2;
	u_in = 0; %zero voltage
    fb=0; % zero voltage
    %v=0; % zero velocity
end


% friction brake input

% non linear efforts
v=p_9/M; %car velocity

e11 = 0.5*rho*Af*Cd*v*v/(abs(v)+n);
e12 = M*g*Cr*(v/(abs(v)+n));

% eqns of motion 
p_dot3 = u_in - (p_3/Lw)*Rw - Tm*(Gr/R)*(p_9/M);
p_dot9 = (Gr/R)*(-bt*(Gr/R)*(p_9/M) + Tm*(p_3/Lw)) - e12 - e11 - fb;


% defining extra variables for output
ext(1) = p_3; % 
ext(2) = p_9; % 

% stacking up derivs
ds = [p_dot3; p_dot9]; 



