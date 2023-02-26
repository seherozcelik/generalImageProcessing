imgs = dir('folder');
for i=3:length(imgs)
    figure
    im1=imread(['folder/' imgs(i).name]);
    splt = split(imgs(i).name,'.');
    im2=imread(['folder/' splt{1} '.jpg']);
    imd=dicomread(['folder/' splt{1} '.dcm']);
    subplot(1,2,1)
    imshow(im2)
    subplot(1,2,2)
    imshowpair(im1,imd)
end
