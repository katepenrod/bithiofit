classdef Gauss1 < handle
   properties
      xdata   % The data to be fit
      ydata
      noise
      ngaussians% number of gaussians to include in fit
   end
   methods
      function obj = Gauss1(xin,yin)
         % This saves the data to be fit in the xdata and ydata properties
         obj.xdata = xin;
         obj.ydata = yin;
      end
      function ydiff = err(obj,par)
         ycalc = obj.ypred(par);
         ydiff = ycalc - obj.ydata;
      end
      function res = npar(obj)
         % returns number of parameters in ypred function
         res = 3 * obj.ngaussians;
      end
      function res = ypred(obj,par)
         % evaluate the function you want to fit;
         %res = par(1) * sin(obj.xdata/par(2));
         %res = par(1) * exp(-obj.xdata.^2/(par(2))^2);
         res = zeros(size(obj.xdata));
         for i = 1:obj.ngaussians
            amplitude = par(1 + 3 * (i-1) ); % will be 1 4 7 etc
            center    = par(2 + 3 * (i-1) ); % will be 2 5 8 etc
            width     = par(3 + 3 * (i-1) ); % will be 3 6 9 etc
            res = res + amplitude*exp(-(obj.xdata-center).^2/width^2);
         end 
      end
   end
end