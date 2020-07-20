function lowpass_kaiser

% ringing specification
delta = 0.001; 
A = -20*log10(delta);

% passband specification
passband = 0.2*pi;
omegac = 0.5*pi;

% kaiser formula
beta = 0.1102*(A - 8.7);
M = ceil((A - 8)/(2.285*passband));

% Compute kaiser window
kaiser_window = kaiser(M+1, beta)';

% Compute ideal lowpass filter
n = 0:M;
hI = sin(omegac * (n - M/2))./(pi*(n - M/2));

% compute final filter
h = hI .* kaiser_window;

%%%%%%%%%%%%%
% Plot filter
%%%%%%%%%%%%%
h1 = figure; pos = get(h1, 'Position'); pos([3 4]) = [600 300]; set(h1, 'Position', pos);
stem(n, h, 'LineWidth', 1.5);
set(gcf, 'PaperPositionMode', 'auto'); set(gca, 'FontSize', 24); saveas(gcf, ['figures/lowpass_impulse_response.eps'], 'epsc');

%%%%%%%%%%%%
% Plot DTFT
%%%%%%%%%%%%
num_samples = 1024;
H = fft(h, num_samples);

omega = 2*pi * (0:(num_samples-1)) / num_samples;
omega2 = fftshift(omega);
omega3 = unwrap(omega2 - 2*pi);

h1 = figure; pos = get(h1, 'Position'); pos([3 4]) = [600 300]; set(h1, 'Position', pos);
plot(omega3, 20*log10(abs(fftshift(H))), 'LineWidth', 1.5);
axis([0 pi -100 20]);

set(gcf, 'PaperPositionMode', 'auto'); set(gca, 'FontSize', 24); saveas(gcf, ['figures/lowpass_DTFT.eps'], 'epsc');
