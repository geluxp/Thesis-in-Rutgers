%输入值z为需要画图的第三维数据
%函数将根据z的值构造红绿色图，0值为白色；正值为红色，正得越多，颜色越红；负值为绿色，负得越多，颜色越绿
function mycolormap=redgreencolormap(z)
N=length(z);
mycolormap=ones(N,3);
maxz=max(z);
minz=min(z);
if (minz<0 && maxz>0)  %若数据z有正有负，则把负数显示为绿色，负得越多，颜色越绿；正数显示为红色，正得越多，颜色越红
    Nneg=round(abs(min(z))/(max(z)-min(z))*N);
    mycolormap(1:Nneg,1)=(linspace(0,0.999,Nneg))';
    mycolormap(1:Nneg,3)=mycolormap(1:Nneg,1);
    
    mycolormap((Nneg+1):N,2)=(linspace(0.999,0,N-Nneg))';
    mycolormap((Nneg+1):N,3)=mycolormap((Nneg+1):N,2);
elseif (minz>=0)  %若数据z没有负数，则全部显示为红色，正得越多，颜色越红
    mycolormap(:,2)=(linspace(1,0,N))';
    mycolormap(:,3)=mycolormap(:,2);
elseif (maxz<=0) %若数据z没有正数，则全部显示为绿色，负得越多，颜色越绿
    mycolormap(:,1)=(linspace(0,1,N))';
    mycolormap(:,3)=mycolormap(:,1);
end


end