clc
clear
%构造测试轮廓
X=[-1,1,1,-1,-1];
Y=[1,1,-1,-1,1];
left_x=min(X);right_x=max(X);down_y=min(Y);up_y=max(Y);upper_r=min([right_x-left_x,up_y-down_y])/2;
%定义相切二分精度
precision=sqrt((right_x-left_x)^2+(up_y-down_y)^2)/2^13;

m=1;
for j=1:m

%构造包含轮廓的矩形的所有像素点
Nx=2^8;Ny=2^8;
pixel_X=linspace(left_x,right_x,Nx);
pixel_Y=linspace(down_y,up_y,Ny);
[pixel_X,pixel_Y]=ndgrid(pixel_X,pixel_Y);
pixel_X=reshape(pixel_X,numel(pixel_X),1);
pixel_Y=reshape(pixel_Y,numel(pixel_Y),1);
%筛选出轮廓内所有像素点
in=inpolygon(pixel_X,pixel_Y,X,Y);
pixel_X=pixel_X(in);pixel_Y=pixel_Y(in);
%plot(X,Y,'*r',pixel_X,pixel_Y,'ob')
%%
%随机搜索百分之一像素提高内切圆半径下限
N=length(pixel_X);
rand_index=randperm(N,floor(N/100));
radius=0;big_r=upper_r;center=[];
for i = rand_index
    tr=radius_get(X,Y,pixel_X(i),pixel_Y(i),radius,big_r,precision);
    if tr>radius
       radius=tr;
       center=[pixel_X(i),pixel_Y(i)];%只有半径变大才允许位置变更，否则保持之前位置不变
    end
end
%%
%循环搜索剩余像素对应内切圆半径
loops_index=1:N;loops_index(rand_index)=[];
for i = loops_index
    tr=radius_get(X,Y,pixel_X(i),pixel_Y(i),radius,big_r,precision);
    if tr>radius
       radius=tr;
       center=[pixel_X(i),pixel_Y(i)];%只有半径变大才允许位置变更，否则保持之前位置不变
    end
end
%%
%效果测试
circle_X=center(1)+radius*cos(linspace(0,2*pi,100));
circle_Y=center(2)+radius*sin(linspace(0,2*pi,100));
left_x=min(abs(circle_X));
right_x=max(X);
down_y=min(abs(circle_Y));
up_y=max(Y);
upper_r=min([right_x-left_x,up_y-down_y])/2;
end
hold on
axis equal
title('轮廓内切圆测试')
plot(X,Y,'LineWidth',2.5)
plot(circle_X,circle_Y,'LineWidth',2)
fill(circle_X,circle_Y,'k')
left_x=min(X);right_x=max(X);down_y=min(Y);up_y=max(Y);upper_r=min([right_x-left_x,up_y-down_y])/2;

hold off
