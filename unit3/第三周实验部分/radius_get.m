
function radius=radius_get(X,Y,pixelx,pixely,small_r,big_r,precision)
radius=small_r;
L=linspace(0,2*pi,360);%ȷ��Բɢ���ʷ���360,720
circle_X=pixelx+radius*cos(L);circle_Y=pixely+radius*sin(L);
if numel(circle_X(~inpolygon(circle_X,circle_Y,X,Y)))>0%���Բɢ����������֮��ĵ�
    return
else
    while big_r-small_r>=precision%���ַ�Ѱ�����뾶
        half_r=(small_r+big_r)/2;
        circle_X=pixelx+half_r*cos(L);circle_Y=pixely+half_r*sin(L);
        if numel(circle_X(~inpolygon(circle_X,circle_Y,X,Y)))>0%���Բɢ����������֮��ĵ�
            big_r=half_r;
        else
            small_r=half_r;    
        end
    end
    radius=small_r;
end
end