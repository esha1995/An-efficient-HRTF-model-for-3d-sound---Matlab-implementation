function[out] = RoomModel(x,yl,yr,gainDB,fs)

%creating 15 ms of delay in samples as suggested by the paper
d = floor(fs * 0.015); 
xd = [zeros(d,1); x];

% if delayed signal is longer than the HRTF signal add the difference to
% make all signals same length
if(length(yl) > length(xd))
    diff = length(yl) - length(xd);
    xd = [xd; zeros(diff,1)];
else
    diff = length(xd) - length(yl);
    yl = [yl; zeros(diff,1)];
    yr = [yr; zeros(diff,1)];
end

% adding a amplitude (Kl and Kr) to the signal
A = db2mag(gainDB);
yl = A .* yl;
yr = A .* yr;

% making the room delay 15 db lower
xd = db2mag(gainDB - 15) .* xd; 

% adding the delayed signal to left and right
y = [(yl + xd) (yr + xd)];

out = y;