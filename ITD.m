function[outL,outR] = ITD(xl,xr,fs,a,c, theta)

TlD = floor(((a + a*theta)/c)*fs);
TrD = floor(((a - a*sin(theta))/c)*fs);

% add delay (zeros) to beginning of signal depending on delay
yl = [zeros(TlD, 1); xl];
yr = [zeros(TrD, 1); xr];

% adding extra to the shorter signal so vectors have equal length
if(length(yl) > length(yr))
   diff = length(yl) - length(yr);
   yr = [yr; zeros(diff,1)];
else
   diff = length(yr) - length(yl);
   yl = [yl; zeros(diff,1)];
end

outL = yl;
outR = yr;