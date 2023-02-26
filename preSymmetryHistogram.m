clear
imname='imName';
dicomim = dicomread(['folder/' imname '.dcm']);
im = imread(['folder/' imname '.png']);

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

for i=0:2:12
    ycx = -a*(cx+i)+a*cx+cy;
    ys = -am*x+am*(cx+i)+ycx;
    
    for j=1:50
        tx = cx+i+j;
        tys = round(-am*tx+am*(cx+i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5 
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    
    for j=1:50
        tx = cx+i-j;
        tys = round(-am*tx+am*(cx+i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    
    plot(x,ys,'r','LineWidth', 1);
    hold on
end

for i=2:2:10
    ycx = -a*(cx-i)+a*cx+cy;
    ys = -am*x+am*(cx-i)+ycx;
    
    for j=1:50
        tx = cx-i+j;
        tys = round(-am*tx+am*(cx-i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    
    for j=1:50
        tx = cx-i-j;
        tys = round(-am*tx+am*(cx-i)+ycx);
        s = sum((im(tys-1:tys+1,tx-1:tx+1)/255).*kernel,'all');
        if s > 0 && s < 5
            plot(tx,tys,'r*','LineWidth', 1.5)
            hold on
        end
    end
    
    plot(x,ys,'r','LineWidth', 1);
    hold on
end


