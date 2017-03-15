function [alpha, beta] = fund_performance(d1,market,d2,fund,d3,risk_free,draw)
%step1. rearrange the data, elimminate NAN and align d1=d2
%step1.2 assume that d3==d1, if not, i will add one more loop then.
%step2. get alpha and beta by regression
%step3. show figure or not
%?????????column, ????????

[m,~]=size(d2);
[n,~]=size(d1);
for_regression_metrix=[];

for i=1:m
    for j=1:n
        if (d2(i,1)==d1(j,1)) && isnan(fund(i,1))==0 && d2(i,1)==d3(j,1)
            for_regression_metrix= [for_regression_metrix ; d2(i,1),fund(i,1),market(j,1),risk_free(j,1)];
        end
    end
end

%just for checking
%disp(for_regression_metrix);
y=for_regression_metrix(:,2)-for_regression_metrix(:,4);
%disp(y);
x=for_regression_metrix(:,3)-for_regression_metrix(:,4);
%disp(x);

p=polyfit(x,y,1);
%disp(p);

alpha = p(2);
beta =p(1);

if draw==1
    figure;
    plot(x,y,'*')
    hold on
    plot(x,polyval(p,x),'-')
else
    return
end
%disp(alpha);
%disp(beta);
end

