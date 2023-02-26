[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300;

imName = 'imName';
imdicom = uint16(dicomread(['folder/' imName '.dcm']));
im = imread(['folder/' imName '.jpg']);
grayIm = rgb2gray(im);
grayIm = grayIm(580:1259,180:900);
grayIm = imresize(grayIm,[224 256]);
recDicom = imregister(imdicom,grayIm,'affine',optimizer,metric); %INVERSE of NORMAL USE
subplot(1,3,1)
imshow(imdicom,[])
subplot(1,3,2)
imshow(imresize(im(580:1259,180:900,:),[224 256]))
subplot(1,3,3)
imshow(recDicom,[])

%imwrite(imdicom,'folder/imName.png')
%imwrite(imresize(im(580:1259,180:900,:),[224 256]),'folder/imName.png')
%imwrite(recDicom, 'folder/imName.png')
