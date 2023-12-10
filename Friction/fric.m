clear; close all; clc;

fric_data = load('fric_data.mat');

x = fric_data.data{11}.Values; %position of cart
v = fric_data.data{15}.Values; % voltage
pwm = fric_data.data{19}.Values; % pwm

% volt plot 
yyaxis left
plot(x, 'LineWidth', 2);
hold on
ylabel('x [m]')
yyaxis right
plot(v, 'LineWidth', 2);
xlim([49 49.5]);
ylabel(['Voltage [V]'])
xlabel('t [s]')
grid
title('Find Static Friction')

xline(49.25, 'LineWidth',2)
yline(2.925, 'LineWidth',2)

plot(49.25, 2.925, '*g','LineWidth',2 )
legend('x(t)', 'V(t)', 'Start line slide',['Critical Voltage' ...
    ''], 'Location','northwest')

critical_voltage = 2.925;


%pwm plot
figure
yyaxis left
plot(x, 'LineWidth', 2);
hold on
ylabel('x [m]')
yyaxis right
plot(pwm, 'LineWidth', 2);
xlim([49 49.5]);
ylabel(['Pwm'])
xlabel('t [s]')
grid
title('Find Static Friction')

legend('x(t)', 'PWM(t)', 'Location','northwest')


