function[out] = HeadShadow(x, T, alfa, beta)

% creating an empty vector for output
y = zeros(length(x), 1);
% going through each sample and applying head shadow filter
for n = 2:(length(x))
    y(n) = ((2*alfa+(T*beta))*x(n)+(-2*alfa+(T*beta))*x(n-1)-(-2+(T*beta))*y(n-1))/(2+(T*beta));
end


out = y; 