imgs = dir('folder');
[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;
for i = 3:length(imgs)
    figure
    subplot(3,2,1)
    imdicom = dicomread(['folder/' imgs(i).name]);
    imshow(imdicom,[])
    title(imgs(i).name)
    subplot(3,2,2)
    splt = split(imgs(i).name,'.');
    im = imread(['folder/' splt{1} '.jpg']);
    grayIm = im(580:1259,180:900,2);
    grayIm = imresize(grayIm,[224 256]);
    grayIm = imregister(grayIm,imdicom,'affine',optimizer,metric);
    imshow(grayIm)
    subplot(3,2,3)
    imL = imread(['folder/' splt{1} '.jpg']);
    imL = imL(670:1100,270:800,:);
    imL = imresize(imL,[224 256]);
    imshow(imL)
    subplot(3,2,4)
    grayIm(160:224,:) = 0;
    %grayIm(1:30,:) = 0;
    %grayIm(:,1:110) = 0;
    %grayIm(:,200:256) = 0;
    B = grayIm > 100;
    CC = bwconncomp(B);
    numOfPixels = cellfun(@numel,CC.PixelIdxList);
    [unused,indexOfMax] = max(numOfPixels);
    B=zeros(size(B));
    B(CC.PixelIdxList{indexOfMax}) = 1;
    imshow(B)
    imwrite(B,['folder/' splt{1} '.png']);
    subplot(3,2,5)
    imshow(im(580:1259,180:900,1))
    subplot(3,2,6)
    imshow(im(580:1259,180:900,3))
    hold on
end
