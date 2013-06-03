cur = 1; %position in for loop
files = char('bithio1.mat', 'bithio2.mat', 'bithio3.mat'); %change as needed to fit different files
for cur = 1:size(files,1)
ldfile = files(cur,:); %variable that determines which file is loaded
load(ldfile);
   spectra(xdata,ydata);
   cur=cur+1;
end
