function im_f = maxFilter(im,sz)
    d = (sz-1)/2;
    [h,w]=size(im);
    im_f = zeros(h,w);
    for i=d+1:h-d
        for j=d+1:w-d
            im_f(i,j)=max(im(i-d:i+d,j-d:j+d),[],'all');
        end
    end
end