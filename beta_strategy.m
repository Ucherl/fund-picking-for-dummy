function [gama,pValue] = beta_strategy(d1,market,d2,fund,d3,risk_free,draw)
% dummy variable D
% IF Rm-Rf>0 ,D=1
% IF Rm-Rf<0 ,D=0
% fundR-Rf = alpha + beta*(Rm-Rf)+gama*(Rm-Rf)*D
% fundR-Rf = alpha + (beta+gama*D)*(Rm-Rf)
% IF gama>0, the strategy is success

[m,~]=size(d2);
[n,~]=size(d1);
[r,~]=size(d3);
for_regression=[];

for i=1:m
    for j=1:n
        for u=1:r
            if  (d2(i,1)==d1(j,1)) && isnan(fund(i,1))==0 && d2(i,1)==d3(u,1)
                for_regression= [for_regression ; d2(i,1),fund(i,1),market(j,1),risk_free(u,1)];
            end
        end
    end
end

[k,~]=size(for_regression);

new_for_regression=[];
for g=1:k-1
    new_for_regression=[new_for_regression; (for_regression(g+1,2)-for_regression(g,2))/for_regression(g,2), (for_regression(g+1,3)-for_regression(g,3))/for_regression(g,3),for_regression(g,4)];
end

%disp(new_for_regression);

y=new_for_regression(:,1)-new_for_regression(:,3);
x=new_for_regression(:,2)-new_for_regression(:,3);

% x2= (Rm-Rf)*D
dummy_D=[];
for t=1:k-1
    if new_for_regression(t,2)-new_for_regression(t,3)>0
        D=1;
    else
        D=0;
    end
    dummy_D=[dummy_D;D];
end


%use \ to get coefficient
A=[x,x.*dummy_D];
%abg=A\y;


[abg,~,STATS]=glmfit(A,y);
%disp(abg)
%disp(STATS.p);
%USE GLMFIT TO OUTPUT GAMA AND P VALUE

    if draw==1
    figure;
    plot(x,y,'*')
    hold on
    fplot(@(tr)abg(1)+(abg(2)+abg(3))*tr,[0 max(x)])
    fplot(@(tr)abg(1)+abg(2)*tr,[min(x) 0])
    %plot(x,abg(1)+(abg(2)+abg(3))*x,'-',x,abg(1)+abg(2)*x,'-');
    
    end

gama=abg(3);
pValue=STATS.p(3);
    
end





