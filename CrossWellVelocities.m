function CrossWellVelicities

%Version 1.0 Written 16:45 31 October 2017. 
    %Purpose: Combining and plotting replicate velocities Operating with E3
    %as of October 31
%Version 2.0: 14 November 2017 Implementation of multi-well comparision functionality. See
%ReplicateVelocities for legacy version for only one experiment
    
% clearvars; close all; clc;

%Define the wells of interest to be looked at
WellCell1 = [19:21;22:23 NaN;43:45;46:47 NaN];
%Define wells for the second data set (must be of same dimensions)
WellCell2 = [3 22 NaN; 24 NaN NaN;6 19 NaN; 4 21 NaN];
TimeWindow = 4;
LegendSet = {'EGF Depleted 500 1','EGF Depleted 500 2','Control 500 1',...
    'Control 500 2','EGF Depleted 1000 1','EGF Depleted 1000 2','Control 1000 1','Control 1000 2'};

[cmap] = cbrewer('qual','Set1',2*size(WellCell1,1));
colorcounter = 0;
itset = 1;

%loop through the conditions
for condition = 1:size(WellCell1,1)
    colorcounter = colorcounter + 1;
    %loop through all the replicates within the conditions

    for replicate = 1:size(WellCell1,2)
       %Exit the loop if the said condition was not run
       if isnan(WellCell1(condition,replicate))==1
           itset = itset + 1;
           continue
       end
       
       well = WellCell1(condition,replicate);
       %load the appropriate data file
       filename = strcat('Z:\ENG_BBCancer_Shared\group\0Zach\Cluster data\EGF (E3) Data\10-31 Data',...
           '\EGF(E3)10_31_17.datawell',num2str(well),'.mat');
       load(filename);
       
% %        %calculate time stable velocities via previous method
% %         velX=storeX(:,(1+TimeWindow):TimeWindow:end)-storeX(:,1:TimeWindow:end-TimeWindow);
% %         velY=storeY(:,(1+TimeWindow):TimeWindow:end)-storeY(:,1:TimeWindow:end-TimeWindow);
        
        %calculate time stable velocities via previous method
        velX=storeX(:,(1+TimeWindow):1:end)-storeX(:,1:1:end-TimeWindow);
        velY=storeY(:,(1+TimeWindow):1:end)-storeY(:,1:1:end-TimeWindow);
        
        %calculate rms velcoities
        velrms = sqrt(velX.^2+velY.^2);
        
        %find the mean velocities 
        meanvel = nanmean(velrms,1);
        timeint = [1:numel(meanvel)];
        timehr = timeint./4;
        
        %plot the results in the appropriate color
        h(itset) = plot(timehr,meanvel,'Color',cmap(colorcounter,:),'linewidth',2);
        hold on
        itset = itset + 1;
    end
     colorcounter = colorcounter + 1;
    %Do it again for the second Conditin
    
   for replicate = 1:size(WellCell2,2)
       %Exit the loop if the said condition was not run
       if isnan(WellCell2(condition,replicate))==1
           itset = itset+1;
           continue
       end
       
       well = WellCell2(condition,replicate);
       %load the appropriate data file
       filename = strcat('Z:\ENG_BBCancer_Shared\group\0Zach\Cluster data\EGF (E6) Data\',...
           'egf(E6)newwell',num2str(well),'.mat');
       load(filename);
       
% %        %calculate time stable velocities via previous method
% %         velX=storeX(:,(1+TimeWindow):TimeWindow:end)-storeX(:,1:TimeWindow:end-TimeWindow);
% %         velY=storeY(:,(1+TimeWindow):TimeWindow:end)-storeY(:,1:TimeWindow:end-TimeWindow);
        
        %calculate time stable velocities via previous method
        velX=storeX(:,(1+TimeWindow):1:end)-storeX(:,1:1:end-TimeWindow);
        velY=storeY(:,(1+TimeWindow):1:end)-storeY(:,1:1:end-TimeWindow);
        
        %calculate rms velcoities
        velrms = sqrt(velX.^2+velY.^2);
        
        %find the mean velocities 
        meanvel = nanmean(velrms,1);
        timeint = [1:numel(meanvel)];
        timehr = timeint./4;
        
        %plot the results in the appropriate color
        h(itset) = plot(timehr,meanvel,'Color',cmap(colorcounter,:),'linewidth',2);
        hold on
        itset = itset + 1;
    end
    
end
uuu = [1:size(WellCell1,2):itset-1];
legend(h(uuu),LegendSet);
title('RMS Mean Velocity Replicate Plot');
xlabel('Time in Hours')
ylabel('Mean Speed in Microns/Hour')

end