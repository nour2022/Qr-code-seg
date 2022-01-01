function i=Pre_processing(Img)
%apply median filter with mask 3x3 to reduce noise 
i=rgb2gray(Img);
i = medfilt2(i, [3 3]);
figure('Name','Image After Processing'),imshow(i);
end