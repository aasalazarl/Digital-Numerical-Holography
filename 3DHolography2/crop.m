clc
clear all;
% Input holgram
for i = 0:15:180
    name = strcat('pic',num2str(i),'.bmp');
    I1 = imread(name);
    %I1 = double(rgb2gray(I1));

    [Ny,Nx] = size(I1);
    minN = min(Ny,Nx);
    % Crop to have rows equal to columns
    I1 = I1(1:minN,1:minN);
    [Ny,Nx] = size(I1);
    Im1 = 1/(Nx*Ny)*sum(sum(I1))
    I1 = I1-Im1;
    outname = strcat('freqency',num2str(i),'.bmp');
    imwrite(I1,outname);
end