clear
imname='imName';
dicomim = dicomread(['folder/' imname '.dcm']);
im = imread(['folder/' imname '.png']);

figure
imshowpair(im,dicomim);
hold on
stats = regionprops('table',im/255,'Centroid','Orientation');
cx = round(stats{1,1}(1));
cy = round(stats{1,1}(2));
theta = stats{1,2};
a = tand(theta);
x = linspace(1,256,256);
y = -a*x+a*cx+cy;
plot(x,y,'r','LineWidth', 1);
hold on

% min axis
am = tand(theta-90);
ym = -am*x+am*cx+cy;
plot(x,ym,'r','LineWidth', 1);
hold on

kernel = uint8([0 1 0; 1 1 1; 0 1 0]);
dr=[];
dl=[];
r=1;
l=1;
re=1;
le=1;

for i=0:2:12
    ycx = -a*(cx+i)+a*cx+cy; %(cx+i,ycx) new middle point
    ys = -am*x+am*(cx+i)+ycx;
    
    for j=1:50
        tx = cx+i+j;
        tys = round(-am*tx+am*(cx+i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5 
            dr(r,re)=sqrt((cx+i-tx)^2+(ycx-tys)^2);
            re=re+1;
            plot(tx,tys,'b*','LineWidth', 1.5)
            hold on
        end
    end
    re=1;
    
    for j=1:50
        tx = cx+i-j;
        tys = round(-am*tx+am*(cx+i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            dl(l,le)=sqrt((cx+i-tx)^2+(ycx-tys)^2);
            le=le+1;
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    le=1;
    
    plot(x,ys,'r','LineWidth', 1);
    hold on
    r=r+1;
    l=l+1;
end

for i=2:2:10
    ycx = -a*(cx-i)+a*cx+cy; %(cx-i,ycx) new middle point
    ys = -am*x+am*(cx-i)+ycx;
    
    for j=1:50
        tx = cx-i+j;
        tys = round(-am*tx+am*(cx-i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            dr(r,re)=sqrt((cx-i-tx)^2+(ycx-tys)^2);
            re=re+1;
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    re=1;
    
    for j=1:50
        tx = cx-i-j;
        tys = round(-am*tx+am*(cx-i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            dl(l,le)=sqrt((cx-i-tx)^2+(ycx-tys)^2);
            le=le+1;
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    le=1;
    
    plot(x,ys,'r','LineWidth', 1);
    hold on
    r=r+1;
    l=l+1;
end

dre=[];
dle=[];

dr(dr == 0) = NaN;
dl(dl == 0) = NaN;

dre(:,1)=min(dr,[],2);
dre(:,2)=max(dr,[],2);
dle(:,1)=min(dl,[],2);
dle(:,2)=max(dl,[],2);

[h,w] = size(dre);
for i=1:h
    if dre(i,2)-dre(i,1) < 3
        dre(i,1) = 0;
    end
end

[h,w] = size(dle);
for i=1:h
    if dle(i,2)-dle(i,1) < 3
        dle(i,1) = 0;
    end
end

%{
dist = abs(dre-dle);
figure
histogram(dist(:,2),5)
title('outer points absolute distance difference');
figure
histogram(dist(:,1),5)
title('inner points absolute distance difference');
%}