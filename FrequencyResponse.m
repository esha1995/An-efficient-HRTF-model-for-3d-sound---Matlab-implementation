% head shadow varables 

c = 343;
theta = -90 * (pi/180);
phi = 0 * (pi/180);
a = 58/100;
T = 1/fs;

beta = (2*c)/a;
alfaL = 1-sin(theta);
alfaR = 1+sin(theta);

bL = [(2*alfaL+(T*beta)) (-2*alfaL+(T*beta))];
aL = [2+(T*beta) -(-2+(T*beta))];

bR = [(2*alfaR+(T*beta)) (-2*alfaR+(T*beta))];
aR= [2+(T*beta) -(-2+(T*beta))];

[HR,fR] = freqz(bR,aR,'whole',2001);
figure(2)
plot(fR/pi,20*log10(abs(HR)))
ax = gca;
ax.YLim = [-80 40];
ax.XLim = [0 1];
ax.XTick = 0:.5:1;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')

[HL,fL] = freqz(bL,aL,'whole',2001);
figure(1)
plot(fL/pi,20*log10(abs(HL)))
ax = gca;
ax.YLim = [-80 40];
ax.XLim = [0 1];
ax.XTick = 0:.5:1;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')