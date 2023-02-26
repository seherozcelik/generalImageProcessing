function createLabels(imageFolder, labelFolder) %manual labeled set

    imgs = dir(imageFolder);
    
    for i = 3:length(imgs)
        im = dicomread([imageFolder '/' imgs(i).name]);
        im = im(160:383,125:380);
        splt = split(imgs(i).name,'.');
        im_label = imread([labelFolder '/' splt{1} '.jpg']);
        im_label = im_label(:,:,1);
        im_label = im_label(670:1100,270:800);
        im_label = imresize(im_label,[224 256]);
        [optimizer,metric] = imregconfig('multimodal');
        optimizer.InitialRadius = optimizer.InitialRadius/3.5;
        optimizer.MaximumIterations = 300;
        registered_label = imregister(im_label,im,'affine',optimizer,metric);
        registered_label = registered_label >= 200;
        CC = bwconncomp(registered_label);
        numPixels = cellfun(@numel,CC.PixelIdxList);
        [biggest,idx] = max(numPixels);
        label = zeros(size(registered_label));
        label(CC.PixelIdxList{idx}) = 1;
        %imwrite(label, ['folder/' splt{1} '.png']);
        %dicomwrite(im, ['folder/' imgs(i).name]);
        figure
        subplot(1,4,1)
        imshowpair(im,label,'montage');
        subplot(1,4,2)
        imshowpair(im,label);
        subplot(1,4,3)
        imshow(im,[]);
        subplot(1,4,4)
        imshow(im_label);
        title(imgs(i).name);
    end
end

