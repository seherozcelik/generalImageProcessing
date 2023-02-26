imgs = dir('folder');
for i = 3:length(imgs)
    figure
    splt = split(imgs(i).name,'.');
    rec = register3D(splt{1});
    imL = imread(['folder/' splt{1} '.png']);
    imshowpair(rec,imL,'montage')
    %imwrite(rec,['folder/' splt{1} '.png']);
end