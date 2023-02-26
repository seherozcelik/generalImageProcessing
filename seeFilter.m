[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;
%filter = ones(9,9)/81;

imname = 'imName';
imdicom = dicomread(['folder/' imname '.dcm']);
im = imread(['folder/' imname '.jpg']);
grayIm = rgb2gray(im);
grayIm = grayIm(580:1259,180:900);
grayIm = imresize(grayIm,[224 256]);
grayIm = imregister(grayIm,imdicom,'affine',optimizer,metric);
%grayImf = maxFilter(grayIm,5);
%grayImfm = minFilter(grayIm,5);
grayImf = adapthisteq(grayIm);
%grayImf = 255*(double(grayImf) / max(double(grayImf),[],'all'));
%grayImf = imfilter(grayIm,filter);
imshowpair(grayIm,grayImf>150,'montage')
%[counts,x] = imhist(grayIm,16);
%T = otsuthresh(counts);
%BW = imbinarize(grayIm,T*3);
%imshow(BW)

