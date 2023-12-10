clear; close all; clc;
% This gain calculation script is based on the script of 
%JITENDRA SINGH. Found on his GITHUB:
% https://github.com/jitendra825/Inverted-Pendulum-Simulink

% Equations for our system is presented in the report.

% Parameters from Our hardware:
Mc = 0.540 + 0.048;% [kg]mass of cart
l = 0.49; % [m] Pendelum length
Lcg = l/2; % [m] lenght to center of mass
l = Lcg;
m = 0.022;% [kg] Mass of pendelum rod
g = 9.81;

%Motor parameters:
Rm = 1.3;%[ohm] motor armature resistence
kb = 0.02;%[vs/rad]back emf constant
kt = 0.02;%[vs/rad]motor touque constant
r =  0.04/(2*pi); %[m]radius pulley motor (and encoder)
m_rotor = 0.100; %[kg] aprooximately
r_rotor =0.020/2; % m
Jm = 0.5*m_rotor*r_rotor^2;
M = Mc+Jm/r^2;

%Very rough estimate:
c = 20; %[N/(m/s)] viscous friction cart. Tias
b = 0.0001;% [Nm/rad/s]Viscous damping pendelum
I = 1/3*m*2*Lcg^2; % Uniform rod moment of inertia


%Calculations from Jitendra for LQR params estimate:
AA = I*(M+m) + M*m*(l^2);
aa = (((m*l)^2)*g)/AA;
bb = ((I +m*(l^2))/AA)*(c + (kb*kt)/(Rm*(r^2)));
cc  = (b*m*l)/AA;
dd  = (m*g*l*(M+m))/AA;
ee  = ((m*l)/AA)*(c + (kb*kt)/(Rm*(r^2)));
ff  = ((M+m)*b)/AA;
mm = ((I +m*(l^2))*kt)/(AA*Rm*r);
nn = (m*l*kt)/(AA*Rm*r);
A  =  [0 0 1 0; 0 0 0 1; 0 aa -bb -cc; 0 dd -ee -ff];
B = [0;0; mm; nn]; 
% Q and R are inspired by matlab example lqr:
Q = diag([1 1 0 0]); % Based on Matlab example
R  = 1; % Based on matlab example
KK = lqr(A,B,Q,R)

% after tuning with swing up active
% K = [-20   120  -20  5] 
