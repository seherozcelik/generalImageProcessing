%{
imgs = dir('folder');
for i=3:length(imgs)
    figure
    im = imread(['folder/' imgs(i).name]);
    imshow(im);
    hold on
    stats = regionprops('table',im,'Centroid','Orientation');
    x = stats{1,1}(1);
    y = stats{1,1}(2);
    h = round(100*tand(stats{1,2}));
    plot([x-100,x+100],[y+h,y-h],'r','LineWidth', 1.5);
end
%}
imname='name';
dicomim = dicomread(['folder/' imname '.dcm']);
im = imread(['folder/' imname '.png']);
figure
subplot(1,4,1)
imshowpair(im,dicomim);
hold on
stats = regionprops('table',im/255,'Centroid','Orientation');
cx = stats{1,1}(1)-3;
cy = stats{1,1}(2);
a = tand(stats{1,2}-38);
x = linspace(1,256,256);
y = -a*x+a*cx+cy;
plot(x,y,'r','LineWidth', 1.5);

im_l = im;
im_r = im;
[h,w]=size(im);
for i=1:h
    l=round((i-cy-a*cx)/(-a));
    if l>256
        l=256;
    end
    if l>0
        im_l(i,l:w)=0;
        im_r(i,1:l)=0;
    end
end
subplot(1,4,2)
imshow(im)
subplot(1,4,3)
imshow(im_l)
subplot(1,4,4)
imshow(im_r)
%imwrite(im_l,['folder1/' imname '.png']);
%imwrite(im_r,['folder2/' imname '.png']);
