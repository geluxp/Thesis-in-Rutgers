%����ֵzΪ��Ҫ��ͼ�ĵ���ά����
%����������z��ֵ�������ɫͼ��0ֵΪ��ɫ����ֵΪ��ɫ������Խ�࣬��ɫԽ�죻��ֵΪ��ɫ������Խ�࣬��ɫԽ��
function mycolormap=redgreencolormap(z)
N=length(z);
mycolormap=ones(N,3);
maxz=max(z);
minz=min(z);
if (minz<0 && maxz>0)  %������z�����и�����Ѹ�����ʾΪ��ɫ������Խ�࣬��ɫԽ�̣�������ʾΪ��ɫ������Խ�࣬��ɫԽ��
    Nneg=round(abs(min(z))/(max(z)-min(z))*N);
    mycolormap(1:Nneg,1)=(linspace(0,0.999,Nneg))';
    mycolormap(1:Nneg,3)=mycolormap(1:Nneg,1);
    
    mycolormap((Nneg+1):N,2)=(linspace(0.999,0,N-Nneg))';
    mycolormap((Nneg+1):N,3)=mycolormap((Nneg+1):N,2);
elseif (minz>=0)  %������zû�и�������ȫ����ʾΪ��ɫ������Խ�࣬��ɫԽ��
    mycolormap(:,2)=(linspace(1,0,N))';
    mycolormap(:,3)=mycolormap(:,2);
elseif (maxz<=0) %������zû����������ȫ����ʾΪ��ɫ������Խ�࣬��ɫԽ��
    mycolormap(:,1)=(linspace(0,1,N))';
    mycolormap(:,3)=mycolormap(:,1);
end


end