imgs = dir('folder');
dicomRef = dicomread('folder/imName.dcm');
for i = 3:length(imgs)
    dicomIm = dicomread(['folder/' imgs(i).name]);
    J = imhistmatch(dicomIm,dicomRef);
    dicomwrite(J,['folder/' imgs(i).name]);
    figure
    imshowpair(J,dicomIm,'montage');
    hold on
end
figure
imshow(dicomRef,[]);