%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EQ2445
% Predictive Coding Schemes in Image Compression
% Authors: Vignesh V Menon, Antoine Camus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
close all;
%% Load test image
%figure;
im_input=imread('Images/KTH_1.JPG');
%im_input=imread('Images/KTH_2.JPG');
%imshow(im_input); % Original image

% Extract color components
im_r = double(im_input(:,:,1));
im_g = double(im_input(:,:,2));
im_b = double(im_input(:,:,3));

%% Test different quantization levels
QP_level=[2, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96, 128];

mse_count = zeros(1, length(QP_level));
psnr_count = zeros(1, length(QP_level));
for i = 1 : length(QP_level)
    error = DPCM_enc(im_r, QP_level(i));
    recon_red = DPCM_dec(error);
    error = DPCM_enc(im_g, QP_level(i));
    recon_green = DPCM_dec(error);
    error = DPCM_enc(im_b, QP_level(i));
    recon_blue = DPCM_dec(error);
    recon_qp = uint8(cat(3,recon_red, recon_green, recon_blue));
    mse_count(i) = immse(im_input, recon_qp);
    psnr_count(i) = psnr(recon_qp, im_input);
end

figure;
plot(QP_level, mse_count);
xlabel('Number of Quantization steps');
ylabel('MSE');

figure;
plot(QP_level, psnr_count);
xlabel('Number of Quantization steps');
ylabel('PSNR');