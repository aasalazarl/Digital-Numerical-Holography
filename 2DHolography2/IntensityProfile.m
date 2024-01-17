function IntensityProfile
% Plots 3D intensity profile of incoming beam

clc
clear all;
% Input holgram
I1 = imread('in_ref7.bmp');
%I1 = double(rgb2gray(I1));
[Ny,Nx] = size(I1);
minN = min(Ny,Nx);
% Crop to have rows equal to columns
I1 = I1(1:minN,1:minN);
[Ny,Nx] = size(I1);
max(I1);
%figure(1)
%mesh(I1);

%-------Substract DC from hologram
Im1 = 1/(Nx*Ny)*sum(sum(I1));
I1 = I1 - Im1;

% Max intensity after DC substraction
Imax = max(I1)

figure(2)
mesh(I1);
%suptile(Reference beam intensity profile)
%title(After DC term substraction)
xlabel('x (pixels)');ylabel('y (pixels)');zlabel('Intensity (uI)');
saveas(gcf,'referenceBeamIntensityProfile.png','png')