%��ȡ����С��������
function [sector] = getSectorArea(u,a,b)
%
Temp = zeros(size(u));
s = size(u);
f = figure;
imshow(Temp);hold on;
x = [a(1) a(2) b(1)];
y = [a(3) a(4) b(2)];
fill(x,y,'w');
saveas(gcf,'area.bmp');   %����figure�ϵĶ���
close(f);
A = imread('area.bmp');
% subplot(221);imshow(A);
B = ~A;          %ȡ��
% subplot(222);imshow(B);
[ym xm] = find(B,1,'first');    %�ҵ������е�һ��Ϊ1��λ��
B = imcrop(A,[xm ym s(2)-1 s(1)-1]);   
B = im2bw(B);
% subplot(223);imshow(B);
sector = and(u,B); %����������ཻ����������
% subplot(224);imshow(sector);

