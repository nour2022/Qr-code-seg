function [x_center,y_center ] = Find_And_Detect_Corners(Thresholding_Img ,Original_IMG)
%this Function returns two arrays (x,y), that contain the x and y of the
%center for each corners 
figure('Name','Detect Corners'),imshow(Original_IMG);
hold on;

All_Connected_From_Img = bwconncomp(Thresholding_Img);
NUM_Of_Pixels = cellfun(@numel,All_Connected_From_Img.PixelIdxList);
Num=All_Connected_From_Img.NumObjects;

x_center=[];
y_center=[];
for i=1:Num

if NUM_Of_Pixels(i)>50
%the Location or the position of the connected component in the image
[X,Y] = ind2sub(size(Thresholding_Img),All_Connected_From_Img.PixelIdxList{i});

X_min=min(X);
Y_min=min(Y);

X_max=max(X);
Y_max=max(Y);

H=X_max-X_min;
W=Y_max-Y_min;

The_Connected_comp = Thresholding_Img(X_min:X_max,Y_min:Y_max);

Val1=Check_If_Square(W,H);

Val2=Check_If_There_BlackSqure_in_center(The_Connected_comp,W,H);

if Val1==1 && Val2==1 

[Val3]=Check_if_there_Black_Border_And_BlackSqure_in_THEcenter(Thresholding_Img,The_Connected_comp,X_min,X_max,Y_min,Y_max,W,H);

if Val3==1

%draw circle around the center of the corner
plot(round((Y_max+Y_min)/2),round((X_max+X_min)/2),'y-x')
x_center=[x_center;round((Y_max+Y_min)/2)];
y_center=[y_center;round((X_max+X_min)/2)];

end
end
end
end
end