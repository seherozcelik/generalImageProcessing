im=imread('folder/imName.png');
im = imrotate(im,-135);
[row,col]=find(im);
row=(row-mean(row))/std(row)-2;
col=(col-mean(col))/std(col)+2;
p = polyfit(m,s,2);
f1 = polyval(p,m);
figure
plot(col,-row,'r*') %col x, row y
hold on
plot(m,f1,'b*')
hold on
plot(m,s,'g*')
hold on
%fo = fitoptions('Method','NonLinearLeastSquares','Lower',[0,0],'Upper',[4,4],'StartPoint',[1 1 1]);
fo = fitoptions('Method','NonLinearLeastSquares');
ft = fittype(@(a, b, c, x) sqrt(a*x.^2+b*x+c)); 
%ft = fittype(@(a, b, c, x) sqrt(c*(a-((x.^2)/b))));
%z = a*m.*s;
%ft = fittype('a*m*s','dependent',{'z'},'independent',{'m','s'},'coefficients',{'a'});
[myfit, gof] = fit(m, s, ft, fo);
plot(myfit)
hold on
th = 0:pi/50:2*pi;
xunit = 2 * cos(th) + 2;
yunit = 2 * sin(th) + 2;
plot(xunit, yunit);
axis equal
%[m,s] = getpts;
%https://www.mathworks.com/help/curvefit/fit.html#bto2vuv-1-fitOptions