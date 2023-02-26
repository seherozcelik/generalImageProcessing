imgs = dir('folder');
k=1;
figure
for i = 3:length(imgs)
    subplot(4,7,k)
    splt = split(imgs(i).name,'.');
    dicomim = dicomread(['folder/' splt{1} '.dcm']);
    imshow(dicomim,[])
    l=length(splt{1});
    title([splt{1}(1:2) splt{1}((l-2):l)])
    
    k = k+1;
    subplot(4,7,k)
    imG = imread(['folder/' imgs(i).name]);
    imshow(imG)
    if k == 2
        title('Gold(Hand)')
    end
    
    k = k+1;
    subplot(4,7,k)
    pred = imread(['folder/' imgs(i).name]);
    imshow(pred)
    if k == 3
        title('Pred All')
    end    

    k = k+1;
    subplot(4,7,k)
    predL = imread(['folder/' imgs(i).name]);
    imshow(predL)
    if k == 4
        title('Pred Left')
    end
    
    k = k+1;
    subplot(4,7,k)
    predR = imread(['folder/' imgs(i).name]);
    imshow(predR)
    if k == 5
        title('Pred Right')
    end    
    
    k = k+1;
    subplot(4,7,k)
    imAll = createAllColored(pred,predR,predL);
    imshow(imAll)
    if k == 6
        title('(A,R,L)=(R,G,B)')
    end
    
    k = k+1;
    subplot(4,7,k)
    imAllDic = showBoundaries(dicomim, uint8(rgb2gray(imAll)>0), [255,0,0]);
    imshow(imAllDic,[])
    
    k = k+1;
    if k == 29
        hold on
        figure
        k = 1;
    end
end

function im = createAllColored(pred,predR,predL)
    im = cat(3,uint8(pred(:,:,1)>68).*255,uint8(predR(:,:,1)>68).*255,uint8(predL(:,:,1)>68).*255);
end
