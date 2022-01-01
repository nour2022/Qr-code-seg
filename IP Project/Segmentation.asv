function [R] = Segmentation(i,x,y)

CP1=[x(1);y(1)];
CP2=[x(2);y(2)];
CP3=[x(3);y(3)];

side1=sqrt(((CP2(1)-CP1(1))^2+(CP2(2)-CP1(2))^2));
side2=sqrt(((CP2(1)-CP3(1))^2+(CP2(2)-CP3(2))^2));
side3=sqrt(((CP1(1)-CP3(1))^2+(CP1(2)-CP3(2))^2));

Sorted_sides=sort([side1;side2;side3]);

d=Sorted_sides(2)-Sorted_sides(1)+10;

if abs(side1-side2)<d
c=CP2;
p1=CP1;
p2=CP3;

elseif abs(side1-side3)<d
c=CP1;
p1=CP2;
p2=CP3;

else
c=CP3;
p1=CP1;
p2=CP2;
end
img = insertShape(i, 'Circle', [c(1),c(2),5], 'Color', 'yellow','LineWidth',2);
figure('Name','Center corner'),imshow(img);

if abs(c(1)-min(x))<10
if p1(2)>= c(2)
orig=[c , p2, p1 ];
else
orig=[c , p1, p2 ];
end

elseif abs(c(1)-max(x))<10
if p1(2)<= c(2)
orig=[c  , p2 , p1 ];
else
orig=[c , p1 , p2 ];
end

elseif abs(c(2)-min(y))<10
if p1(1)<= c(1)

orig=[c , p2 , p1 ];
else
orig=[c , p1 , p2 ];
end

elseif abs(c(2)-max(y))<10
if p1(1)>= c(1)
orig=[c, p2 , p1 ];
else
orig=[c  , p1 ,  p2 ];

end

end

correct_position=[0+min(x)  floor(Sorted_sides(1))+min(x)     0+min(x)       ;
                  0+min(y)    0+min(y)         floor(Sorted_sides(1))+min(y) ];
              %     0 s1 0
              %     0 0  s1

correct_position = correct_position';
orig1=orig';

Trans = fitgeotrans(orig1,correct_position, 'affine');
Res = imwarp(i, Trans);
figure('Name','After Rotate'),imshow(Res);

img = Res;
bw = ~im2bw(img);
clrborder = imclearborder(imclose(bw, strel('square', 9)));
qr = bwareafilt(clrborder,1);
figure('Name','After crop111'),imshow(qr);
qr = imdilate(qr, strel('square', 9));
figure('Name','After Rotate222'),imshow(qr);
[r,c] = find(qr);
rect = [min(c) min(r) max(c)-min(c) max(r)-min(r)];

hold on; 
rectangle('position', rect, 'EdgeColor', 'g', 'LineWidth', 2);
qr_img = imcrop(img, rect);
figure; imshow(qr_img);
R = qr_img;
end