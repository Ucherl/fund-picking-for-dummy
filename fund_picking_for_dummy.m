function [output] = fund_picking_for_dummy( input)
%step1 organize data, make sure they are qualified
%step2 catagorize input with market,risk_free,fund
%step3 use fund_performance to output alpha & beta
%step4 arrange output from step3
disp('make sure the matrix you input conform with d1,market,d2,risk_free,di,funds');

[~,m]=size(input);
AB_table=[];
for i=1:(m-4)/2
    [alpha,beta]=fund_performance(input(:,1),input(:,2),input(:,2*i+3),input(:,2*i+4),input(:,3),input(:,4),1);
    
    AB_table=[AB_table;alpha,beta];    
end

disp('....alpha......beta')
disp(AB_table)

end

