function fresnelReconstruction_coin
%% Reading holograms and substracting DC term
clc
clear all;
% Input holgram
I1 = imread('queen7.bmp');
Er = imread('in_queen_ref4.bmp');
I1 = double(rgb2gray(I1));
Er = double(rgb2gray(Er));
[Ny,Nx] = size(I1);
minN = min(Ny,Nx);
% Crop to have rows equal to columns
I1 = I1(1:minN,1:minN);
Er = Er(1:minN,1:minN);
[Ny,Nx] = size(I1);

%-------Substract DC from hologram
Im1 = 1/(Nx*Ny)*sum(sum(I1));
I1 = I1 - Im1;
Emr = 1/(Nx*Ny)*sum(sum(Er));
Er = Er - Emr;

figure
%%-Reconstruction using the discrete Fresnel transform (eqn. (4.3) in Nehmetallah)
lambda0 = 635*10^-6;    % wavelength in mm. Changes depending on used laser
k0 = 2*pi/lambda0;
delx = 2.2*10^-3;   % pixel spacing in CCD in x-direction in mm (original 2.2 microns)
dely = 2.2*10^-3;   % pixel spacing in CCD in y-direction in mm (original 2.2 microns)
nx = [-Nx/2:1:Nx/2-1];  % create array of points (k in eqn. (4.4b) in Nehemetallah)
ny = [-Ny/2:1:Ny/2-1];  % l in eqn. (4.4b) in Nehmetallah
X = nx*delx;
Y = ny*dely;
[XX,YY] = meshgrid(X,Y);    % create a mesh of spatial coordinates
d = [450];  % distance of object to CCD in mm (depends on setup)
% Generate image
for m=1:1:length(d)
    resolution_mm=lambda0*d(m)/(Nx*delx);
    size(I1);
    size(Er);
    w=exp(-1i*pi/(lambda0*d(m))*(XX.^2+YY.^2)); %See eq. 4.3b
    % See eq. 4.3a:
    %Rec_image=fftshift(ifft2(I1.*Er.*w)); %after
    Rec_image=fftshift(ifft2(I1.*48.9439.*w)); %afterCorrected
    %Rec_image=fftshift(ifft2(I1.*w)); %before
    Mag_Rec_image=abs(Rec_image);       %intensity pattern
    colormap(gray(256))
    imagesc(nx*resolution_mm,ny*resolution_mm,Mag_Rec_image)
    %title('Reconstructed Hologram')
    xlabel('mm')
    ylabel('mm')
    %title(strcat('Reconstruction at distance:',...
    %num2str(d),'mm'))
    %axis([-15 15 -15 15])
    axis([ 1 17 -10 6]) %zoomIn
    %axis([-(Nx/2)*resolution_mm (Nx/2)*resolution_mm -(Ny/2-1)*resolution_mm ...
        %(Ny/2-1)*resolution_mm])
    %title(strcat('Reconstruction at distance:',num2str(d(m)),'mm'))
    pause(0.5)

%saveas(gcf,'coinReconstructionAfter.png','png')
%saveas(gcf,'coinReconstructionAfter_zoomIn.png','png')
%saveas(gcf,'coinReconstructionBefore.png','png')
%saveas(gcf,'coinReconstructionBefore_zoomIn.png','png')
%saveas(gcf,'coinReconstructionAfterCorrected.png','png')
saveas(gcf,'coinReconstructionAfterCorrected_zoomIn.png','png')
end