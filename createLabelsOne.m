im = dicomread('folder/imName.dcm');
im = im(160:383,125:380);
im_label = imread('folder/imName.jpg');
im_label = im_label(:,:,1);
im_label = im_label(670:1300,200:730); %im_label(670:1100,270:800);
im_label = imresize(im_label,[224 256]);
%im_label(150:224,:) = 0;
[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;
registered_label = imregister(im_label,im,'affine',optimizer,metric);
registered_label = registered_label >= 245; %200
CC = bwconncomp(registered_label);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
label = zeros(size(registered_label));
label(CC.PixelIdxList{idx}) = 1;
%imwrite(label, 'folder/imName.png');
figure
subplot(1,4,1)
imshowpair(im,label,'montage');
subplot(1,4,2)
imshowpair(im,label);
subplot(1,4,3)
imshow(im,[]);
subplot(1,4,4)
imshow(im_label);
title('name');
