ll=hull{1,1};
for i=3:5:(h-2)
    for j=3:5:(w-2)
        if sum(ll(i-2:i+2,j-2:j+2).*kernel,'all') > 0
            ll(i-2:i+2,j-2:j+2) = 1;
        end
    end
end
imshow(ll);