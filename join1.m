%% Testing fitting: fit of generated data
load('kate.mat');
xdata = wavelength;
noise = 0.1;

ydata = 1.0*exp(-(xdata-300).^2/50^2) + 0.8 * exp(-(xdata-450).^2/40^2) + 0.6 * exp(-(xdata-600).^2/30^2) + 0.4 * exp(-(xdata-750).^2/20^2) + noise * randn(size(xdata));
f1 = Gauss1(xdata,ydata);
f1.ngaussians = 4;

start =  [1 300 50 0.8 450 50 0.6 600 50 0.4 750 50];

limits=[];
[x,resnorm,residual,exitflag,output] = lsqnonlin(@f1.err,start);
   
figure(100);
plot(xdata,ydata,'r.');
ypred = f1.ypred(x);
hold on
plot (xdata, ypred, 'b.')

%%
%% If I plot the spectrum for forty_abs
figure(200)
plot(wavelength, forty_abs, 'k.');

% I see a peak with amplitude 0.05 at 350 nm with a width about 50 
% so I use these as the parameters for the first gaussian.
% I also see peak with amplitude 0.12 at 450 nm with a width of about 50 
% A small sholder with amplitude 0.05 at 510, and something
% with amplitude 0.01 at 750. So a reasonable start is:
start =  [0.05 350 50 0.12 450 50 0.05 510 50 0.01 750 50];

% I create a Gauss object with the x and y data used in the plot
f2 = Gauss1(wavelength,forty_abs);
f2.ngaussians = 4;
% I do the fit, saving the paramters and the sum of squared error
[pfit2, resnorm, residual, exitflag, output] = lsqnonlin(@f2.err,start);

ypred = f2.ypred(pfit2);
hold on;
plot (wavelength, ypred, 'y.');
disp(['res norm = ',num2str(resnorm)]);
disp(['first peak  = ',num2str(pfit2(1:3))]);
disp(['second peak = ',num2str(pfit2(4:6))]);
disp(['third peak  = ',num2str(pfit2(7:9))]);
disp(['fourth peak = ',num2str(pfit2(10:12))]);
%%
figure (300);
plot(wavelength, fifty_abs, 'k.');

%start =  [0.13 350 50 0.12 450 50 0.05 510 50 0.01 750 50];
start = [0.05 350 50 0.8 450 50 0.6 600 50 0.4 750 50];

f3 = Gauss1(wavelength,fifty_abs);
f3.ngaussians = 4;
[pfit3, resnorm] = lsqnonlin(@f3.err,start);

ypred = f3.ypred(pfit3);
hold on;
plot (wavelength, ypred, 'y.');
%%
figure (400);
plot(wavelength, sixty_abs, 'k.');

start = [0.05 350 50 0.8 450 50 0.6 600 50 0.4 750 50];

f4 = Gauss1(wavelength,sixty_abs);
f4.ngaussians = 4;
[pfit4, resnorm] = lsqnonlin(@f4.err,start);

ypred = f4.ypred(pfit4);
hold on;
plot (wavelength, ypred, 'y.');
%%
figure (500);
plot(wavelength, seventy_abs, 'k.');

start = [0.05 350 50 0.8 450 50 0.6 600 50 0.4 750 50];


f5 = Gauss1(wavelength,seventy_abs);
f5.ngaussians = 4;
[pfit5, resnorm] = lsqnonlin(@f5.err,start);

ypred = f5.ypred(pfit5);
hold on;
plot (wavelength, ypred, 'y.');