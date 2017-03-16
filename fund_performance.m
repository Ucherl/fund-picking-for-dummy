function [alpha, beta] = fund_performance(d1,market,d2,fund,d3,risk_free,draw)
%step1. rearrange the data, elimminate NAN and align d1=d2
%step1.2 assume that d3==d1, if not, i will add one more loop then.
%step1.3 convert NAV to return
%step2. get alpha and beta by regression
%step3. show figure or not
%?????????column, ????????

[m,~]=size(d2);
[n,~]=size(d1);
for_regression=[];

for i=1:m
    for j=1:n
        if (d2(i,1)==d1(j,1)) && isnan(fund(i,1))==0 && d2(i,1)==d3(j,1)
            for_regression= [for_regression ; d2(i,1),fund(i,1),market(j,1),risk_free(j,1)];
        end
    end
end

[k,~]=size(for_regression);



new_for_regression=[];
for g=1:k-1
    new_for_regression=[new_for_regression; (for_regression(g+1,2)-for_regression(g,2))/for_regression(g,2), (for_regression(g+1,3)-for_regression(g,3))/for_regression(g,3),for_regression(g+1,4)];
end



%just for checking
%disp(new_for_regression);
y=new_for_regression(:,1)-new_for_regression(:,3);
%disp(y);
x=new_for_regression(:,2)-new_for_regression(:,3);
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

