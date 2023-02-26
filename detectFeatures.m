im = dicomread('folder/imName.dcm');
im_c = dicomread('folder/imName2.dcm');
figure
subplot(2,2,1)
[optimizer,metric] = imregconfig('multimodal');
optimizer.InitialRadius = optimizer.InitialRadius/3.5;
optimizer.MaximumIterations = 300; %default 100
im_c_reg = imregister(im_c,im,'affine',optimizer,metric);

dicomwrite(im_c_reg,'fodler/imName.dcm');

imshowpair(im_c_reg,im, 'montage');
hold on


%features_c = detectMinEigenFeatures(im_c);
%specFeatures_c = selectStrongest(features_c,100);
%[feat,validPts] = extractFeatures(im,specFeatures);
%[feat_c,validPts_c] = extractFeatures(im_c,specFeatures_c);
%idxPairs = matchFeatures(feat,feat_c);
%matchedPoints = validPts(idxPairs(:,1));
%matchedPoints_c = validPts_c(idxPairs(:,2));
%figure
%'falsecolor', 'blend', 'montage'
%showMatchedFeatures(im,im_c,matchedPoints,matchedPoints_c,'montage')
%'similarity' | 'affine' | 'projective'
%[tform,inlierPoints_c,inlierPoints] = estimateGeometricTransform(matchedPoints_c,matchedPoints,'affine');
%figure
%'falsecolor', 'blend', 'montage'
%showMatchedFeatures(im,im_c,inlierPoints,inlierPoints_c,'montage')