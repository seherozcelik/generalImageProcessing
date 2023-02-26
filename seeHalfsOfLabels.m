imgs = dir('folder');
k=1;
figure
for i = 3:length(imgs)
    subplot(5,3,k)
    k = k+1;
    splt = split(imgs(i).name,'.');
    imname=splt{1};
    dicomim = dicomread(['folder/' imname '.dcm']);
    im = imread(['folder/' imname '.png']);
    imshowpair(im,dicomim);
    subplot(5,3,k)
    k = k+1;
    imR = imread(['folder/' imname '.png']);
    imshowpair(imR,dicomim);
    subplot(5,3,k)
    k = k+1;
    imL = imread(['folder/' imname '.png']);
    imshowpair(imL,dicomim);
    if k == 16
        hold on
        figure
        k = 1;
    end
end
