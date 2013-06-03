%GUI to obtain start values for spectral data fitting
function spectra(xdata,ydata)
   %gets data of the spectrum from .mat file
   %will need to create .mat file for each spectrum
   %each .mat file will contain two variables (xdata,ydata)
   fig = figure;
   plot(xdata, ydata, 'k.-', 'linewidth', 2);
   xlabel('Wavelength(nm)');
   ylabel('Amplitude');
   grid on;
   set(fig,'position',[300,100,600,600]);
   storedata = [];
   dcm_obj = datacursormode(fig);
   set(dcm_obj,'DisplayStyle','datatip','SnapToDataVertex','on','Enable','on','UpdateFcn',@myupdatefcn);
   hb = uicontrol('style','text');
   set(hb,'position',[350,520,200,30],'string','For each peak: Select top, then right limit, then left limit.');
   hc = uicontrol('style','pushbutton');
   set(hc,'position',[450,500,100,20],'string','I am finished','callback',@readout);
   hd = uicontrol('style','pushbutton');
   set(hd,'position',[350,500,100,20],'string','Start over','callback',@resetdata);
   function txt = myupdatefcn(~,gcf)
      %customizes text of data tip
      %stores position of data tip to variable
      pos = get(gcf,'Position');
      storedata(end+1,:) = pos;
      txt = {['Wavelength: ',num2str(pos(1))],...
         ['Amplitude: ',num2str(pos(2))]};
   end
   function readout(cur,~,~)
      %displays data sent to Gauss1
      %setting number of gaussians and creating start data for lsqnonlin
         if length(storedata) == 3
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 1;
         elseif length(storedata) == 6
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2 storedata(4,2) storedata(4,1) (storedata(5,1)-storedata(6,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 2;
         elseif length(storedata) == 9
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2 storedata(4,2) storedata(4,1) (storedata(5,1)-storedata(6,1))/2 storedata(7,2) storedata(7,1) (storedata(8,1)-storedata(9,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 3;
         elseif length(storedata) == 12
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2 storedata(4,2) storedata(4,1) (storedata(5,1)-storedata(6,1))/2 storedata(7,2) storedata(7,1) (storedata(8,1)-storedata(9,1))/2 storedata(10,2) storedata(10,1) (storedata(11,1)-storedata(12,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 4;
         elseif length(storedata) == 15
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2 storedata(4,2) storedata(4,1) (storedata(5,1)-storedata(6,1))/2 storedata(7,2) storedata(7,1) (storedata(8,1)-storedata(9,1))/2 storedata(10,2) storedata(10,1) (storedata(11,1)-storedata(12,1))/2 storedata(13,2) storedata(13,1) (storedata(14,1)-storedata(15,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 5;
         elseif length(storedata) == 18
            start = [storedata(1,2) storedata(1,1) (storedata(2,1)-storedata(3,1))/2 storedata(4,2) storedata(4,1) (storedata(5,1)-storedata(6,1))/2 storedata(7,2) storedata(7,1) (storedata(8,1)-storedata(9,1))/2 storedata(10,2) storedata(10,1) (storedata(11,1)-storedata(12,1))/2 storedata(13,2) storedata(13,1) (storedata(14,1)-storedata(15,1))/2 storedata(16,2) storedata(16,1) (storedata(17,1)-storedata(18,1))/2];
            disp(start);
            f2 = Gauss1(xdata, ydata);
            f2.ngaussians = 6;
         end
      %running lsqnonlin
      [pfit2, resnorm, ~, ~, output] = lsqnonlin(@f2.err,start);
      ypred = f2.ypred(pfit2);
      hold on;
      plot (xdata, ydata,'k.',xdata,ypred,'m:','linewidth',3);
      grid on;
      set(gcf,'position',[300,50,600,600]);
      line1 = ['res norm = ',num2str(resnorm)];
      line8 = output;
      disp(line1);
      %writing results to file and customizing results for number of
      %gaussians
         if length(storedata) == 3
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            disp(line2); 
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            elseif length(storedata) == 6
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            line3 = ['second peak = ',num2str(pfit2(4:6))];
            disp(line2); 
            disp(line3);
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, line3, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            elseif length(storedata) == 9
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            line3 = ['second peak = ',num2str(pfit2(4:6))];
            line4 = ['third peak  = ',num2str(pfit2(7:9))];
            disp(line2); 
            disp(line3);
            disp(line4);
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, line3, line4, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            elseif length(storedata) ==12
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            line3 = ['second peak = ',num2str(pfit2(4:6))];
            line4 = ['third peak  = ',num2str(pfit2(7:9))];
            line5 = ['fourth peak = ',num2str(pfit2(10:12))];
            disp(line2); 
            disp(line3);
            disp(line4);
            disp(line5);
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, line3, line4, line5, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            elseif length(storedata) ==15
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            line3 = ['second peak = ',num2str(pfit2(4:6))];
            line4 = ['third peak  = ',num2str(pfit2(7:9))];
            line5 = ['fourth peak = ',num2str(pfit2(10:12))];
            line6 = ['fifth peak = ',num2str(pfit2(13:15))];
            disp(line2); 
            disp(line3);
            disp(line4);
            disp(line5);
            disp(line6);
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s\n %s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, line3, line4, line5, line6, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            elseif length(storedata) ==18
            line2 = ['first peak  = ',num2str(pfit2(1:3))];
            line3 = ['second peak = ',num2str(pfit2(4:6))];
            line4 = ['third peak  = ',num2str(pfit2(7:9))];
            line5 = ['fourth peak = ',num2str(pfit2(10:12))];
            line6 = ['fifth peak = ',num2str(pfit2(13:15))];
            line7 = ['sixth peak = ',num2str(pfit2(16:18))];
            disp(line2); 
            disp(line3);
            disp(line4);
            disp(line5);
            disp(line6);
            disp(line7);
            fileID = fopen('results.txt', 'a+');
            fprintf(fileID, '%s\n %s\n %s\n %s\n %s\n %s\n %s\n %s\n %s %s\n %s %s\n %s %s\n %s %s\n %s %s\n', 'New Result', line1, line2, line3, line4, line5, line6, line7, 'output.firstorderopt = ', output.firstorderopt, 'output.iterations = ', output.iterations, 'output.funcCount = ', output.funcCount, 'output.algorithm = ', output.algorithm, 'output.message = ', output.message);
            fclose(fileID);
            end
            disp(line8);
   end
   function resetdata(~,~)
      storedata = [];
   end
end