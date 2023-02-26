function pseudo = register3D(imName)
    [optimizer,metric] = imregconfig('multimodal');
    optimizer.InitialRadius = optimizer.InitialRadius/3.5;
    optimizer.MaximumIterations = 300;
    
    imdicom = dicomread(['petSet/trainingAuto/' imName '.dcm']);
    im = imread(['petSet/pseudoColor/' imName '.jpg']);
    grayIm = rgb2gray(im);
    grayIm = grayIm(580:1259,180:900);
    grayIm = imresize(grayIm,[224 256]);
    grayIm = imregister(grayIm,imdicom,'affine',optimizer,metric);
    
    gray1 = im(:,:,1);
    gray1 = gray1(580:1259,180:900);
    gray1 = imresize(gray1,[224 256]);
    gray1 = imregister(gray1,grayIm,'affine',optimizer,metric);
    
    gray2 = im(:,:,2);
    gray2 = gray2(580:1259,180:900);
    gray2 = imresize(gray2,[224 256]);
    gray2 = imregister(gray2,grayIm,'affine',optimizer,metric);
    
    gray3 = im(:,:,3);
    gray3 = gray3(580:1259,180:900);
    gray3 = imresize(gray3,[224 256]);
    gray3 = imregister(gray3,grayIm,'affine',optimizer,metric);
    
    pseudo = cat(3,gray1,gray2,gray3);
end