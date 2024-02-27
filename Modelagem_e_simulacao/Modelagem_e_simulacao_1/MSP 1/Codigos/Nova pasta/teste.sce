clc
clear
mode(-1)

// Define the ODE system
function dy = ode_system(t, y)
    dy = [y(2); -y(1)];
endfunction

// Set the time range and initial conditions
t0 = 0;
tf = 10;
y0 = [1; 0];

// Solve the ODE using the ode() function
[t, y] = ode(t0, tf, y0, ode_system);

// Plot the solution
plot(t, y(1,:));
xlabel("Time (t)");
ylabel("Solution (y)");
