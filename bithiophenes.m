cur = 1;
files = char('bithio1.mat', 'bithio2.mat', 'bithio3.mat');
for cur = 1:size(files,1)
ldfile = files(cur,:);
load(ldfile);
   spectra(xdata,ydata);
   cur=cur+1;
end
