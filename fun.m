%wavelength = 1;
width = 1;
amplitude = 1;
noise = 0.1;
%xdata = 0:0.1:4*pi;
%ydata = amplitude * sin(xdata/wavelength) + noise * rand(size(xdata));
xdata = -5:5;
ydata = amplitude * exp(-xdata.^2/width^2) + noise * rand(size(xdata));
f1 = funcClass(xdata,ydata);

start = [2 2];

pfit = lsqnonlin(@f1.err,start);