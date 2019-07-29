% Solving the heat equation with periodic boundary conditions using the FFT

close all;

% The following parameters can be edited

% Diffusivity coefficient
alpha = 1; 
% Boundary
x0 = 0; xf = 2*pi;
% Initial time
t0 = 0;
% Initial condition
u0 = @(x) sin(x);
% Number of time samples
N = 10000;
% Number of frequency/space samples (must be a power of 2)
M = 2^8;
% Time between time samples
h = 0.0001;

% Do not edit any of the following code other than to produce plots etc.

% Time range
tf = t0 + (N-1)*h;
t = t0:h:tf;
% Space between xs
delta = (xf - x0) / M;
% Space range
x = x0:delta:xf-delta;
% Frequency range
k = (-M/2:M/2-1)/(M*delta);

% Get samples of initial condition at each point in space
u0samples = arrayfun(u0, x);
% Get samples of initial condition at each frequency
u0hat = realfft(u0samples);
% Shift for zero-centred frequency range
u0hat = fftshift(u0hat);
% M values of k and N values of t
uhat = zeros(M,N);
% Insert initial condition as first column (first time) of uhat matrix
uhat(:,1) = u0hat';

% M values of x and N values of t
u = zeros(M,N);
for i = 1:M % for each frequency k (each row)
    curr_k = k(i);
    w = h*pi*pi*curr_k*curr_k*alpha*alpha;
    for j = 2:N % for each time t (each column)
        % Euler's method
        uhat(i,j) = (1 - 4*w)*uhat(i,j-1);
    end    
end

% For each time (each column), convert from frequency domain to space domain
for i = 1:N
    uhat(:,i) = fftshift(uhat(:,i));
    u(:,i) = realifft(uhat(:,i)')';
end
k = fftshift(k);
[K T] = meshgrid(k,t);
[X T] = meshgrid(x,t);

% Exact solution for comparison
uexact = @(x,t) exp(-alpha*alpha*t) * sin(x);
U = arrayfun(uexact, X, T);
% surf(X,T,U)

% Surface plot of solution
figure;
surf(X,T,u','EdgeColor','flat');
% title('Heat equation');
xlabel('Space'); ylabel('Time'); zlabel('Temperature');

% Animated plot of solution
% figure;
% plt = plot(NaN, NaN);
% xlabel('Space'); ylabel('Temperature');
% xlim([min(x) max(x)]); ylim([min(min(u)) max(max(u))]);
% for i = 1:length(t)
%     pause(0.00001);
%     plot(x, u(:,i));
%     % imagesc(u(:,i)');
%     drawnow;
% end
