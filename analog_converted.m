
clc; clear; close all;

% === Low Pass Filter Function ===
function [xm1, fr1] = low(fc)
    delta1 = 0.1;
    fs = 8000;
    A = -20 * log10(delta1);
    w1 = 2 * pi * fc / fs;
    temp = 1 + ((A - 8) / (2.285 * w1));
    N = ceil((temp - 1) / 2);
    n = -N:N;
    h = w1 * sinc(w1 * n / pi);
    xm1 = h;
    fr1 = abs(fft(h));
end

% === High Pass Filter Function ===
function [xmh, frh] = highpass(fc)
    delta1 = 0.1;
    fs = 8000;
    A = -20 * log10(delta1);
    w1 = 2 * pi * fc / fs;
    temp = 1 + ((A - 8) / (2.285 * w1));
    N = ceil((temp - 1) / 2);
    n = -N:N;
    del = zeros(1, 2 * N + 1); del(N + 1) = 1;
    h = del - (w1 * sinc(w1 * n / pi));
    xmh = h;
    frh = abs(fft(h));
end

% === Band Pass Filter Function ===
function [xmb, frb] = bandpass(fl, fh)
    delta1 = 0.1;
    delta2 = 0.1;
    fs = 8000;
    A = -20 * log10(min([delta1, delta2]));
    w1 = 2 * pi * fl / fs;
    w2 = 2 * pi * fh / fs;
    temp = 1 + ((A - 8) / (2.285 * (w2 - w1)));
    N = ceil((temp - 1) / 2);
    n = -N:N;
    h = (w2 - w1) * sinc((w2 - w1) * n / pi);
    xmb = h;
    frb = abs(fft(h));
end

% === Frequency Spectrum Plot Function ===
function plot_spectrum(signal, fs, label_str, f_min, f_max)
    N = length(signal);
    S = abs(fft(signal));
    f = fs * (0:N - 1) / N;
    index_limit = find(f >= f_min & f <= f_max);
    f_plot = f(index_limit);
    S_plot = S(index_limit);

    figure;
    plot(f_plot, S_plot);
    title(['Frequency Spectrum - ', label_str], 'FontSize', 12);
    xlabel('Frequency (Hz)', 'FontSize', 10);
    ylabel('|Magnitude|', 'FontSize', 10);
    grid on;
end

% === Load Audio File ===
[y, fs] = audioread('WhatsApp Audio 2025-04-01 at 11.33.37_7c47a7b8.wav');
y = y(:)';  % Convert to row vector

% === Filter Design ===
fc_L = 300;
[xm1, fr1] = low(fc_L);

fc_H = 4000;
[xmh, frh] = highpass(fc_H);

fl = 300;
fh = 4000;
[xmb, frb] = bandpass(fl, fh);

% === Set Gain Values ===
gain_L = 0.8;    % Low frequencies
gain_B = 1.5;    % Mid frequencies
gain_H = 1.2;    % High frequencies

% === Apply Filters ===
sig_L = conv(y * gain_L, xm1);
sig_B = conv(y * gain_B, xmb);
sig_H = conv(y * gain_H, xmh);

% === Combine and Normalize Output ===
sig_T = sig_L + sig_B + sig_H;
sig_T = sig_T / max(abs(sig_T));  % Normalize

% === TIME DOMAIN PLOTS ===
figure;
plot(y);
title('Original Audio Signal', 'FontSize', 12);
xlabel('Sample Index'); ylabel('Amplitude');

figure;
plot(sig_T);
title('Filtered Output Signal', 'FontSize', 12);
xlabel('Sample Index'); ylabel('Amplitude');

% === FREQUENCY DOMAIN PLOTS ===
plot_spectrum(y, fs, "Original Signal", 0, 6000);
plot_spectrum(sig_L, fs, "Low-Pass Filtered", 0, 300);
plot_spectrum(sig_B, fs, "Band-Pass Filtered", 300, 4000);
plot_spectrum(sig_H, fs, "High-Pass Filtered", 4000, 6000);

% === PLAYBACK ===
sound(y, fs);     % Original
pause(length(y)/fs + 1);  % Wait for original to finish
sound(sig_T, fs); % Filtered
