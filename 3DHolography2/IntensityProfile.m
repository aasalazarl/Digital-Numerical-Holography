function IntensityProfile
% Plots 3D intensity profile of incoming beam

clc
clear all;
% Input holgram
%I1 = imread('ref_sq0.bmp');
I1 = imread('pic0.bmp');
%I1 = double(rgb2gray(I1));
[Ny,Nx] = size(I1);
minN = min(Ny,Nx);
% Crop to have rows equal to columns
I1 = I1(1:minN,1:minN);
[Ny,Nx] = size(I1);

%figure(1)
%mesh(I1);

%-------Substract DC from hologram
Im1 = 1/(Nx*Ny)*sum(sum(I1));
I1 = I1 - Im1;

figure(2)
mesh(I1);
%suptitle('Reference beam intensity profile')
%suptitle('Combined (reference and object beam) intensity profile')
%title('After DC term substraction')
xlabel('x (pixels)');ylabel('y (pixels)');zlabel('Intensity (uI)');
%saveas(gcf,'referenceBeamIntensityProfile.png','png')
%saveas(gcf,'combinedBeamIntensityProfile.png','png')