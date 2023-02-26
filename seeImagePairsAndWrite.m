imgs = dir('folder');
for i = 3:length(imgs)
    figure
    subplot(2,2,1)
    imdicom = dicomread(['folder/' imgs(i).name]);
    imshow(imdicom,[])
    title(imgs(i).name)
    subplot(2,2,2)
    splt = split(imgs(i).name,'.');
    im = imread(['folder/' splt{1} '.jpg']);
    [grayIm,grayImRef] = adjustIntensity(splt{1},'imName');
    imshow(grayIm)
    subplot(2,2,3)
    imL = imread(['folder/' splt{1} '.jpg']);
    imL = imL(670:1100,270:800,:);
    imL = imresize(imL,[224 256]);
    imshow(imL)
    subplot(2,2,4)
    [counts,x] = imhist(grayIm,16);
    T = otsuthresh(counts);
    B = imbinarize(grayIm,T*3);
    CC = bwconncomp(B);
    numOfPixels = cellfun(@numel,CC.PixelIdxList);
    [unused,indexOfMax] = max(numOfPixels);
    B=zeros(size(B));
    B(CC.PixelIdxList{indexOfMax}) = 1;
    imshow(B)
    %imwrite(B,['folder/' splt{1} '.png']);
    hold on
end
