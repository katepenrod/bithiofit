classdef Gauss < handle
   properties
      xdata   % The data to be fit
      ydata
      noise
   end
   methods
      function obj = Gauss(xin,yin)
         % This saves the data to be fit in the xdata and ydata properties
         obj.xdata = xin;
         obj.ydata = yin;
      end
      function ydiff = err(obj,par)
         ycalc = obj.ypred(par);
         ydiff = ycalc - obj.ydata;
      end
      function res = ypred(obj,par)
         % evaluate the function you want to fit
         %res = par(1) * sin(obj.xdata/par(2));
         %res = par(1) * exp(-obj.xdata.^2/(par(2))^2);
         res = par(1)*exp(-(obj.xdata-par(2)).^2/par(3)^2) + par(4) * exp(-(obj.xdata-par(5)).^2/par(6)^2) + par(7) * exp(-(obj.xdata-par(8)).^2/par(9)^2) + par(10) * exp(-(obj.xdata-par(11)).^2/par(12)^2);
      end   
   end
end