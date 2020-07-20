function CompareDFTandFFT

n = 1:1024;

h1 = figure; pos = get(h1, 'Position'); pos([3 4]) = [600 300]; set(h1, 'Position', pos);
plot(n, n.^2, 'k', 'LineWidth', 2); hold on;
plot(n, n.*log2(n), 'r', 'LineWidth', 2); 

axis([1 1024 0 12e5]);
set(gcf, 'PaperPositionMode', 'auto'); set(gca, 'FontSize', 24); saveas(gcf, ['figures/DFT_FFT.eps'], 'epsc');
