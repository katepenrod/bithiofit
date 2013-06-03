xdata = wavelength;
noise = 0.1;
 
ydata = 1.0*exp(-(xdata-300).^2/50^2) + 0.8 * exp(-(xdata-450).^2/40^2) + 0.6 * exp(-(xdata-600).^2/30^2) + 0.4 * exp(-(xdata-750).^2/20^2) + noise * randn(size(xdata));
f1 = Gauss(xdata,ydata);
f3 = Gauss(xdata, monomer);

start =  [1 300 50 0.8 450 50 0.6 600 50 0.4 750 50];%[0.05 350 50 0.12 450 50 0.05 510 50 0.01 750 50];

%pfit = lsqnonlin(@f1.err,start);
[pfit, resnorm] = lsqnonlin(@f1.err,start);
   
figure(100);
plot(xdata,ydata,'r.');
ypred = f1.ypred(pfit);
hold on
plot (xdata, ypred, 'b.')

plot (xdata, monomer, 'k.');
[pfit3, resnorm] = lsqnonlin(@f3.err,start);
ypred = f3.ypred(pfit3);
plot (xdata, ypred, 'y.')
