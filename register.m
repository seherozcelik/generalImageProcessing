function grayIm = register(imName)
    [optimizer,metric] = imregconfig('multimodal');
    optimizer.InitialRadius = optimizer.InitialRadius/3.5;
    optimizer.MaximumIterations = 300;
    
    imdicom = dicomread(['folder/' imName '.dcm']);
    im = imread(['folder/' imName '.jpg']);
    grayIm = rgb2gray(im);
    grayIm = grayIm(580:1259,180:900);
    grayIm = imresize(grayIm,[224 256]);
    grayIm = imregister(grayIm,imdicom,'affine',optimizer,metric);
end