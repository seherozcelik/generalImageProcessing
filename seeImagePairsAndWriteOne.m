
[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;

imname = 'imName';

figure
subplot(2,2,1)
imdicom = dicomread(['folder/' imname '.dcm']);
imshow(imdicom,[])
title(imname)
subplot(2,2,2)
im = imread(['folder/' imname '.jpg']);
grayIm = rgb2gray(im);
grayIm = grayIm(580:1259,180:900);
grayIm = imresize(grayIm,[224 256]);
grayIm = imregister(grayIm,imdicom,'affine',optimizer,metric);
imshow(grayIm)
subplot(2,2,3)
imL = imread(['folder/' imname '.jpg']);
imL = imL(670:1100,270:800,:);
imL = imresize(imL,[224 256]);
imshow(imL)
subplot(2,2,4)
grayIm(160:224,:) = 0;
filter = ones(5,5)/25;
filtered=imfilter(grayIm,filter);
B = grayIm > 100;
CC = bwconncomp(B);
numOfPixels = cellfun(@numel,CC.PixelIdxList);
[unused,indexOfMax] = max(numOfPixels);
B=zeros(size(B));
B(CC.PixelIdxList{indexOfMax}) = 1;
imshow(B)
%imwrite(B,['folder/' imname '.png']);

