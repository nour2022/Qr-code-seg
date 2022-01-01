
function [R]=Main(path)

IMG= imread(path);
I=Pre_processing(IMG);

se = strel('disk',3);
J = imsubtract(imadd(I,imtophat(I,se)),imbothat(I,se));
I=imbinarize(J,'adaptive','ForegroundPolarity','dark','Sensitivity',0.5);

figure('Name','Thresholding Image'),imshow(I);
[x,y]=Find_And_Detect_Corners(I ,IMG);
Corner_Count=size(x,1);
if Corner_Count==3
R = Segmentation(IMG,x,y);

else
%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Corner_Count

y_min=100;
flag=0;

for j=1:Corner_Count

if i~=j && x(i)~=-1 && x(j)~=-1

C1=[x(i);y(i)];
C2=[x(j);y(j)];
d1 = sqrt(((C2(1)-C1(1))^2+(C2(2)-C1(2))^2));

for k=1:Corner_Count
if k~=i  &&  k~=j && x(k)~=-1

C3=[x(k);y(k)];

d2 = sqrt(((C3(1)-C1(1))^2+(C3(2)-C1(2))^2));

d3 = sqrt(((C3(1)-C2(1))^2+(C3(2)-C2(2))^2));

if abs(d1-d2)< 10  && abs((d1^2+d2^2)-d3^2)<1000

if d1<y_min

Position=[C1' ; C2'  ; C3' ];

y_min=d1;

I1=i;
J=j;
K=k;
flag=1;

end

end

end

end

end

end

if flag==1
R = Segmentation(IMG,Position(:,1),Position(:,2));
x(I1)=-1;
x(J)=-1;
x(K)=-1;

end

end
end
end