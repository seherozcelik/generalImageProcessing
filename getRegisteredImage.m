function registered_image = getRegisteredImage(distorted_image, image)

    im = dicomread(image);
    im_c = dicomread(distorted_image);
    [optimizer,metric] = imregconfig('multimodal');
    optimizer.InitialRadius = optimizer.InitialRadius/3.5;
    optimizer.MaximumIterations = 300; %default 100
    registered_image = imregister(im_c,im,'affine',optimizer,metric);
    
end

% example: registered_image = getRegisteredImage('distoted_image_address','image_adress'); 
