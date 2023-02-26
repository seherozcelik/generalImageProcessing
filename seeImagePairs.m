imgs = dir('folder');
k=1;
figure
for i = 3:length(imgs)
    subplot(4,6,k)
    imdicom = dicomread(['folder/' imgs(i).name]);
    imshow(imdicom,[])
    splt = split(imgs(i).name,'.');
    l=length(splt{1});
    title([splt{1}(1:2) splt{1}((l-2):l)])
    k = k+1;
    subplot(4,6,k)
    imL = imread(['folder/' splt{1} '.jpg']);
    imL = imL(670:1100,270:800,:);
    imL = imresize(imL,[224 256]);
    imshow(imL)
    if k == 2
        title('Manual Annotations')
    end
    k = k+1;
    subplot(4,6,k)
    imLA = imread(['folder/' splt{1} '.png']);
    imshow(imLA);
    if k == 3
        title('Gray Pet-Traditional')
    end
    k = k+1;
    subplot(4,6,k)
    imLAB = showBoundaries(imdicom, uint8(imLA>0), [255,0,0]);
    imshow(imLAB,[])
    if k == 4
        title('Gray Pet-Traditional')
    end
    k = k+1;
    subplot(4,6,k)
    imP = imread(['folder/' splt{1} '.png']);
    imshow(imP);
    if k == 5
        title('Gray Pet-UNet')
    end
    k = k+1;
    subplot(4,6,k)
    imPA = showBoundaries(imdicom, uint8(imP(:,:,1)>68), [255,0,0]);
    imshow(imPA,[])
    if k == 6
        title('Gray Pet-UNet')
    end
    k = k+1;
    if k == 25
        hold on
        figure
        k = 1;
    end
end
