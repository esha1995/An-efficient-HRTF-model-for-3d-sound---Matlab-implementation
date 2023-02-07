function[out] = HRTF(x,fs,azimuthAngle,elevationAngle,headRadiusCM,gainDB)

% force to be mono if stereo as the paper specifies a mono signal as input
if(size(x,2) >= 2)
    x = sum(x, 2) / size(x, 2);
end

% setting variables needed
c = 343;
theta = azimuthAngle * (pi/180);
phi = elevationAngle * (pi/180);
a = headRadiusCM/100;
T = 1/fs;

% head shadow varables 
beta = (2*c)/a;
alfaL = 1-sin(theta);
alfaR = 1+sin(theta);

% adding head shadow to singal
yl = HeadShadow(x,T,alfaL,beta);
yr = HeadShadow(x,T,alfaR,beta);

% add delay (zeros) to beginning of signal
[yl,yr] = ITD(yl,yr,fs,a,c,theta);

% PANNAE ECHO
yl = PinnaEchoFunction(yl,theta,phi);
yr = PinnaEchoFunction(yr,theta,phi);

% creating the "room model" / mix
y = RoomModel(x,yl,yr,gainDB,fs);


out = y;