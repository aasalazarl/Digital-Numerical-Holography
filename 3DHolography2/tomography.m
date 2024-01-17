%This code reconstructs the 13 angle spring tomography
format compact
close all

%Reconstruction Parameters
scale = .05;  %scale for resizing the holograms (conserves memory)
d = [0.33];
w = 635e-9;
dx = 2.2e-6;
padsize = 1950;  %size of zero padding (increases resolution)

%for i = linspace(1,length(d),4)

ref = rot90(imread('ref_sq0.bmp','bmp'),2);

obj = rot90(imread('pic0.bmp','bmp'),2);
H0 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H0 = myLoftAndRotate(H0,scale,0);  %lofts H0, but doesn't rotate

obj = rot90(imread('pic15.bmp','bmp'),2);
H15 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H15 = myLoftAndRotate(H15,scale,15);  %lofts H0, but doesn't rotate

obj = rot90(imread('pic30.bmp','bmp'),2);
H30 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H30 = myLoftAndRotate(H30,scale,30);  %lofts and rotates by 45 degres


obj = rot90(imread('pic45.bmp','bmp'),2);
H45 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H45 = myLoftAndRotate(H45,scale,45);  %lofts and rotates by 45 degres

obj = rot90(imread('pic60.bmp','bmp'),2);
H60 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H60 = myLoftAndRotate(H60,scale,60);  %lofts H0, but doesn't rotate


obj = rot90(imread('pic75.bmp','bmp'),2);
H75 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H75 = myLoftAndRotate(H75,scale,75);  %lofts H0, but doesn't rotate

obj = rot90(imread('pic90.bmp','bmp'),2);
H90 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H90 = myLoftAndRotate(H90,scale,90);  


obj = rot90(imread('pic105.bmp','bmp'),2);
H105 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H105 = myLoftAndRotate(H105,scale,105);  

obj = rot90(imread('pic120.bmp','bmp'),2);
H120 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H120 = myLoftAndRotate(H120,scale,120);  


obj = rot90(imread('pic135.bmp','bmp'),2);
H135 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H135 = myLoftAndRotate(H135,scale,135);  

obj = rot90(imread('pic150.bmp','bmp'),2);
H150 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H150 = myLoftAndRotate(H150,scale,150);  

obj = rot90(imread('pic165.bmp','bmp'),2);
H165 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H165 = myLoftAndRotate(H165,scale,165);  

obj = rot90(imread('pic180.bmp','bmp'),2);
H180 = abs(myFresnel(obj,d(i),w,dx,false,1,1,padsize,ref));
H180 = myLoftAndRotate(H180,scale,180);  

%
%%  Multiply the various angles
H13 = H0.*H15.*H30.*H45.*H60.*H75.*H90.*H105.*H120.*H135.*H150.*H165.*H180;
figure(i)
myDisplay3d(H13,0.0003) %all 13 Angles (0.0003 threshold is best)
view(-68,28); axis tight
grid on
%title(strcat('13 Angle Tomographic Reconstruction at distance = ',num2str(d(i)),' cm'))
    %save 13angle.mat H13
%% Multiply the various angles
%figure(1)
%H7 = H0.*H30.*H60.*H90.*H120.*H150.*H180;  %7 angles 
%myDisplay3d(H7,0.06) %7 Angles (0.06 threshold is best)
%view(-68,28); axis tight
%grid on
%title('7 Angle Tomographic Reconstruction')
% save 7_angle_spring.mat H7

%% Reconstruct with alternate angles (as desired)
%H4 = H0.*H45.*H90.*H135.*H180;  %4 angles (best threshold 0.2)
%myDisplay3d(H4,0.2)
% H2 = H0.*H90; % 2 Angles  (best threshold 0.4)

%%  Automatically set tick marks on the axis of the figures
s = length(H0);
Inc = (w*d(i)/((1944+2*padsize)*(dx)))/scale;  %1944 is original hologram size
Inc = Inc*1000; %change increment to (mm) for plotting

tickmarksx = 1:floor(s/6):s;
tickmarksy = 1:floor(s/6):s;
tickmarksz = 1:floor(s/6):s;
scalex = 0:floor(s/6)*Inc:(Inc*length(H0));
scaley = 0:floor(s/6)*Inc:(Inc*length(H0));
scalez = 0:floor(s/6)*Inc:(Inc*length(H0));

set(gca,'XTick',tickmarksx)
set(gca,'XTickLabel',scalex)
set(gca,'YTick',tickmarksy)
set(gca,'YTickLabel',scaley)
set(gca,'ZTick',tickmarksz)
set(gca,'ZTickLabel',scalez)
ylabel('y (mm)') 
xlabel('x (mm)')
zlabel('z (mm)')

savefig(strcat('13AngleTomograpy_',num2str(d(i)),'.fig'))
saveas(gcf,strcat('13AngleTomography_',num2str(d(i)),'.png'),'png')

%end
