clear
imgs = dir('folder');
k=1;
figure
for i = 3:length(imgs)
    subplot(4,5,k)
    splt = split(imgs(i).name,'.');
    imname=splt{1};
    dicomim = dicomread(['folder/' imname '.dcm']);
    imshow(dicomim,[]);
    if k == 1
        title('CT image')
    end
    
    k = k+1;
    subplot(4,5,k)
    imPred = imread(['folder/' imname '.png']);
    imshow(imPred);
    if k == 2
        title('PredictionR')
    end
    
    k = k+1;
    subplot(4,5,k)
    imPred = imread(['folder/' imname '.png']);
    imshow(imPred);
    if k == 3
        title('PredictionL')
    end
    
    k = k+1;
    subplot(4,5,k)
    imPred = imread(['petSet/predictionsAll/' imname '.png']);
    imshow(imPred);
    if k == 4
        title('PredictionAll')
    end
    
    k = k+1;
    subplot(4,5,k)
    gold = imread(['petSet/labelAll/' imname '.png']);
    imshow(gold);
    if k == 5
        title('Gold')
    end
    
    k = k+1;
    if k == 21
        hold on
        figure
        k = 1;
    end
end
