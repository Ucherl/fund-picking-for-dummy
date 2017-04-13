function [output] = fund_picking_for_dummy( input)
%step1 organize data, make sure they are qualified
%step2 catagorize input with market,risk_free,fund
%step3 use fund_performance to output alpha & beta
%step4 arrange output from step3
disp('make sure the matrix you input conform with d1,market,d2,risk_free,di,funds_currency,funds_NAV');

[~,m]=size(input);
input=flipud(input);
AB_table=[];
for i=1:(m-5)/2
    [alpha,beta,a_Pvalue,b_Pvalue]=fund_performance(input(:,1),input(:,2),input(:,5),input(:,2*i+5),input(:,3),input(:,4),0);
    [gama,g_Pvalue] = beta_strategy(input(:,1),input(:,2),input(:,5),input(:,2*i+5),input(:,3),input(:,4),0);
    AB_table=[AB_table;i,alpha,a_Pvalue,beta,b_Pvalue,gama,g_Pvalue];    
end

%disp('....alpha......beta......gama')
disp(AB_table)

output=AB_table;
end

