imgs = dir('folder');
k=1;
figure
for i = 3:length(imgs)
    splt = split(imgs(i).name,'.');
    subplot(4,6,k)
    k = k+1;
    imH = imread(['folder/' splt{1} '.jpg']);
    imH = imH(670:1100,270:800,:);
    imH = imresize(imH,[224 256]);
    imshow(imH)
    title(splt{1})
    subplot(4,6,k)
    k = k+1;
    imPs = imread(['folder/' imgs(i).name]);
    imshow(imPs)
    subplot(4,6,k)
    k = k+1;
    imG = imread(['folder/' imgs(i).name]);
    imshow(imG)
    title('gray')
    subplot(4,6,k)
    k = k+1;
    imP = imread(['folder/' imgs(i).name]);
    imshow(imP)
    title('pseudo')
    subplot(4,6,k)
    k = k+1;
    imLA = imread(['folder/' imgs(i).name]);
    imshow(imLA)
    title('grayIntensity')
    subplot(4,6,k)
    k = k+1;
    imL = imread(['folder/' imgs(i).name]);
    imshow(imL)
    title('traditional')
    if k == 25
        hold on
        figure
        k = 1;
    end
end
