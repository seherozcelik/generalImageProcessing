dirName = './annotations/';

allNames = dir(dirName);
for imNo = 4 : 358
    im = imread([dirName allNames(imNo).name]);
    fname = allNames(imNo).name(1:end-4);
    [dx, dy] = size(im);
    bnd = zeros(dx, dy);
    for i = 1 : dx
        for j = 1 : dy
            if im(i, j)
                if i > 1  && im(i-1, j) ~= im(i, j), bnd(i, j) = 1; end
                if i < dx && im(i+1, j) ~= im(i, j), bnd(i, j) = 1; end
                if j > 1  && im(i, j-1) ~= im(i, j), bnd(i, j) = 1; end
                if j < dy && im(i, j+1) ~= im(i, j), bnd(i, j) = 1; end
            
                if i > 1  && j > 1  && im(i-1, j-1) ~= im(i, j), bnd(i, j) = 1; end
                if i > 1  && j < dy && im(i-1, j+1) ~= im(i, j), bnd(i, j) = 1; end
                if i < dx && j > 1  && im(i+1, j-1) ~= im(i, j), bnd(i, j) = 1; end
                if i < dx && j < dy && im(i+1, j+1) ~= im(i, j), bnd(i, j) = 1; end
            end
        end
    end
    bnd8 = uint8(bnd*255);
    im8 = uint8(im > 0) * 255;
    imwrite(im8, ['./images-of-annotations/' fname '_gold.png']);
    imwrite(bnd8, ['./images-of-boundary-points/' fname '_bnd.png']);

    fid = fopen(['./xy-of-boundary-points/' fname '_bnd.txt'], 'w');
    for i = 1 : dx
        for j = 1 : dy
            if bnd(i, j)
                fprintf(fid, '%d, %d\n', i, j);
            end
        end
    end
    fclose(fid);
end
