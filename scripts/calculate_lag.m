function lags = calculate_lag(C14_results,d18O_results,lag_interp)

% loop through cores
for i = 1:length(C14_results.summary)
    C14_samples = C14_results.summary(i).age_samples;
    C14_depths = C14_results.summary(i).depth;
    d18O_depths = d18O_results.summary(i).depth;
    d18O_samples = d18O_results.summary(i).age_samples;

    % loop through each C14 sample
    for j = 1:500%length(C14_samples(1,:))
        % get depths of each C14 sample corresponding to lag_interp times
        depths(:,j) = interp1(C14_samples(:,j),C14_depths,lag_interp);
    end
    
    lag_core = [];
    for j = 1:length(depths(1,:))
        % finds ages of d18O samples at lag_interp depths
        d18O_ages = interp1(d18O_depths,d18O_samples,depths(:,j));
        lag_core(j).lag = d18O_ages - lag_interp';
    end
    lags(i).name = C14_results.summary(i).name;
    lags(i).age = lag_interp;
    lags(i).samples = [lag_core(:).lag];
    lags(i).median = median(lags(i).samples,2);
    lags(i).lower_95 = quantile(lags(i).samples,0.025,2);
    lags(i).upper_95 = quantile(lags(i).samples,0.975,2);
end



        


    
    
    
    
    
    

