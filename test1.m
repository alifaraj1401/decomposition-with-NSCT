clc
clear all
addpath('nsct')
load('paviatest150.mat')
wavelengthRange = [430 860];
numBands = 102;
wavelength = linspace(wavelengthRange(1),wavelengthRange(2),numBands);
HR = paviatest150 ;
[rows ,cols,band]=size(HR);

appcttest=zeros(rows ,cols,band);
detcttest1=zeros(rows ,cols,band);
detcttest2=zeros(rows ,cols,band);

%%%%%%%%%%%% Parameteters %%%%%%%%%%%%%%%%%
nlevels = [0,0] ;        % Decomposition level
pfilter = 'pyr' ;        % Pyramidal filter
dfilter = 'dmaxflat7' ;      % Directional filter
%%%%%%%%%%%% Nonsubsampled Contourlet decomposition %%%%%%%%%%%%%%%%
i=1;
while i <= band

    coeffshr= nsctdec( HR(:,:,i), nlevels, dfilter, pfilter );
    appcttest(: ,:,i)=coeffshr{1};
    detcttest1(: ,:,i)=coeffshr{2};
    detcttest2(: ,:,i)=coeffshr{3};
    i = i + 1;

end
%%%%%%%%%%%%% Display the decomposed image %%%%%%%%%%%%%%%

hcube = hypercube(HR,wavelength);
HRRGB = colorize(hcube,'Method','RGB','ContrastStretching',true);
figure(1),imshow(HRRGB(:,:,:));
title('original image')

hcube = hypercube(appcttest,wavelength);
appcttestRGB = colorize(hcube,'Method','RGB','ContrastStretching',true);
figure(2),imshow(appcttestRGB(:,:,:));
title('appcttest image')

hcube = hypercube(detcttest1,wavelength);
detcttest1RGB = colorize(hcube,'Method','RGB','ContrastStretching',true);
figure(3),imshow(detcttest1RGB(:,:,:));
title('det1cttest image')

hcube = hypercube(detcttest2,wavelength);
detcttest2RGB = colorize(hcube,'Method','RGB','ContrastStretching',true);
figure(4),imshow(detcttest2RGB(:,:,:));
title('det2cttest image')


