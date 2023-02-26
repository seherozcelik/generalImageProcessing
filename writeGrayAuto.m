imgs = dir('folder');
for i = 3:length(imgs)
    splt = split(imgs(i).name,'.');
    %rec = register(splt{1});
    %imwrite(rec,['folder/' splt{1} '.png']);
    [grayIm,grayImRef] = adjustIntensity(splt{1},'imName');
    imwrite(grayIm,['folder/' splt{1} '.png']);
end