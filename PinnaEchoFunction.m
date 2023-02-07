function[out] =  PinnaEchoFunction(x,theta,phi)

P = [0.5 -1 0.5 -0.25 0.25]; % the magnitude of each echo

% all constants for the pinnae echo
A = [1 5 5 5 5];
B = [2 4 7 11 13];
D = [1 0.5 0.5 0.5 0.5];

%calculating all of the delays
d = zeros(5,1);
for n = 1:5
   d(n) = A(n)*cos(abs(theta)/2)*sin(D(n)*((90*(pi/180))) - phi) + B(n);
end

% creating a FIR based on the delays and the magnitude of each delay
% first impulse is set to 1, as the input signal also passes through
% (based on the article)

h = zeros(max(ceil(d)),1); % the impulse response as the length of the longest delay
h(1) = 1; % first to one (input signal passing through)
for n = 1:5
    % as we want the fractional part of the delay as-well, the ceil is
    % found which is d2, and then d1 as the sample before in the FIR.
    % we use the fractional part to calculate the weight of the two.
    d2 = ceil(d(n));
    d1 = d2 - 1;

    % calculating the fraction of the delay by subtracting the floored delay from
    % the delay
    frac = d(n) - floor(d(n));

    w2 = frac;     % the weight of d2 based on the fractional part
    w1 = (1-frac); % the weight of d1 based on the fractional part
   
    h(d2) = h(d2) + P(n) * w2;

    % as it is possible for d1 to be 0 (as it is subtracted by 1) we need
    % to check it is over 0
    if(d1 > 0)
        h(d1) = h(d1) + P(n) * w1;
    end
end


y = zeros(length(x) + ceil(max(d)),1);

for n = 1:length(y)
   if n < length(x)
     y(n) = x(n);       
       for k = 1:length(P)
          frac = d(k) - floor(d(k));
          if n > (floor(d(k)) + 1) 
              y(n) = y(n) + (P(k) * x(n - floor(d(k))) * (1-frac) + P(k) * x(n - ceil(d(k))) * frac);
          end
       end
   end
end
  

out = y;