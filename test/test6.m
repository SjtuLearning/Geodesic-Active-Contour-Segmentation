clear
clc
x=0:pi/100:2*pi;
y=sin(x);
h=plot(x,y);  % hΪplot�ߵľ��handle
set(gcf,'position',[80,100,400,600])
% ��ͼ������Ϊ����Ļ���½� [80��100]����
% ͼ���С����Ϊ400*600����
set(gcf,'color',[1,1,1]) % ����ɫ����Ϊ��ɫ
mkdir image 
% �ڵ�ǰ�ļ������½�image�ļ��У�����Ѵ��ڻ�warning����Ӱ������

% ========================
saveas(gcf,['image\','test1.jpg'])

% ========================
f=getframe(gcf);
imwrite(f.cdata,['image\','test2.jpg'])

