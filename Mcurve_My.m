function [Maxm,X,Y,Img] = Mcurve_My(rimage1,rimage2,step,rfield)
%   MCURVE_MY    ����ͼ����׼������ߺ���׼ͼ��
%   ����˵����    image1��image2Ϊ�ο�ͼ���ģ��ͼ��
%                stepΪ�����Ⱥ���ʱ����x��y����ƽ��ʱ�Ĳ���
%                rfield��׼����ѡ��
%                methodѡ���Ⱥ�����Ĭ��Ϊ�����Ϣ��׼MI
%   ���������    Maxm����Ⱥ���ֵ
%                X��Y��׼ʱx��y�����ƽ�Ƴ���
%
%   ���ߣ�
%   �汾��V1.0
%   �޸ģ�V1.1   ��������ϵ��ͼ������Ϊԭ��    2009.07.23
%   �޸ģ�V1.2   ��׼�������ѡ��
% �Ҷȼ�
if isa(rimage1,'uint16')
    image1 = double(rimage1)/65535*255;
else
    image1 = double(rimage1);
end
if isa(rimage2,'uint16')
    image2 = double(rimage2)/65535*255;
else
    image2 = double(rimage2);
end
% �ο�ͼ�񼰴�С
image1 = round(image1);
image2 = round(image2);
[mr,nr] = size(image1);
[mf,nf] = size(image2);
% 2009.07.23��������ϵԭ�㡪��ͼ������
wzx1 = (mr-1)/2;
wzy1 = (nr-1)/2;
wzx2 = (mf-1)/2;
wzy2 = (nf-1)/2;

% if method == 'MI';
%     % ���㻥��Ϣ��ʽ
%     Mi_method = questdlg('ʹ�����ּ���MI����','��ʽѡ��','����Ϣ','��һ������Ϣ','����Ϣ');
% end
k = 1;
for x = wzx1-rfield+wzx2:step:wzx1+rfield+wzx2 % ����ͼ����Բο�ͼ��ƽ��+-rfield����
    l = 1;
    if x <= mr
        for y = wzy1-rfield+wzy2:step:wzy1+rfield+wzy2
            if y <= nr
                Im_F = image2(mf-x+1:mf,nf-y+1:nf);
                Im_R = image1(1:x,1:y);
            else
                Im_F = image2(mf-x+1:mf,1:nf+nr+1-y);
                Im_R = image1(1:x,y-nf+1:nr);
            end
%             if method == 'MI'
                MeV(k,l) = mi(Im_R,Im_F);
                l = l+1;
%             end
        end
    else
        for y = wzy1-rfield+wzy2:step:wzy1+rfield+wzy2
            if y <= nr
                Im_F = image2(1:mf+mr+1-x,nf-y+1:nf);
                Im_R = image1(x-mf+1:mr,1:y);
            else
                Im_F = image2(1:mf+mr+1-x,1:nf+nr+1-y);
                Im_R = image1(x-mf+1:mr,y-nf+1:nr);
            end
%             if method == 'MI'
                MeV(k,l) = mi(Im_R,Im_F);
                l = l+1;
%             end
        end
    end
    k = k+1;
end
% ���
% x = wzx1-rfield+wzx2:step:wzx1+rfield+wzx2;
% y = wzy1-rfield+wzy2:step:wzy1+rfield+wzy2;
% x = x-(wzx1+wzx2);y = y-(wzy1+wzy2);
% [x,y] = meshgrid(x,y);
% mesh(x,y,MeV);
% title('�������');

[Maxm,ind] = max(MeV(:));
[X,Y] = ind2sub(size(MeV),ind);
X = (X-1)*step;Y = (Y-1)*step; % ƽ�����ظ���
% ģ��ͼ��ֱ���x��y��ƽ��(X-1)*step��(Y-1)*step���ص����ο�ͼ����׼
% ��ʱ������ͼ������λ�ڲο�ͼ������ϵ(wzx1-rfield+(X-1)*step,wzy1-rfield+(Y-1)*step)��
se = translate(strel(1),[X-rfield Y-rfield]);

Img = imdilate(rimage2,se);
% subplot(121);imagesc(image2);colormap(gray);
% subplot(122);imagesc(Img);colormap(gray);
% H.Position = [132 258 260 260];
% figure(H)
% % subplot(1,3,1);
% imagesc(image2)
% title('ԭʼ����ͼ��');
% colormap(gray)
% % subplot(1,3,2);
% H.Position = [402 258 260 260];
% figure(H)
% imagesc(image1)
% title('ԭʼ�ο�ͼ��')
% colormap(gray)
% 
% % subplot(1,3,3);
% h1 = get(gca,'Position');
% x = h1(1);y = h1(2);w = h1(3);h  = h1(4);  %0.13,0.11,0.775,0.8015
% X1 = wzx1-rfield+X;Y1 = wzy1-rfield+Y;   %128.5,72.5
% H.Position = [672 258 260 260];
% figure(H)
% 
% axes('Position',[w/mr*(X1-(mf-1)/2)+x,h/nr*(Y1-(nf-1)/2)+y,w/mr*mf,h/nr*nf]);
% imagesc(image2)
% title('��׼ͼ��')
% colormap (gray)