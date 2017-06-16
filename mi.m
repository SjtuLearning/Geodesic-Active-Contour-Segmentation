 function MuInf = mi(image1,image2)
%   MI    ����Ϣ��ȣ�Mutual Information�����㺯��
%   method����ѡ����㻥��Ϣ���ǹ�һ������Ϣ��Normalized Mutual Information��
%   ���ߣ�lskyp    2009.07.23
%   �汾��V1.0
% ����ֱ��ͼ��һ��
% image1 = imread('c:\matlab\drlse\1.bmp');
% image2 = imread('c:\matlab\drlse\8.bmp');
% method = '����Ϣ';
Joint_h = Jointh_My(image1,image2);
[r,c] = size(Joint_h);    %256*256
N_Jh = Joint_h./(r*c);
Marg_A = sum(N_Jh);
Marg_B = sum(N_Jh,2);
H_A = 0;H_B = 0;
% �غ���
for k = 1:r
    if Marg_A(k) ~= 0
        H_A = H_A+(-Marg_A(k)*log2(Marg_A(k)));
    end
end
for k = 1:c
    if Marg_B(k) ~= 0
        H_B = H_B+(-Marg_B(k)*log2(Marg_B(k)));
    end
end
H_AB = sum(sum(-N_Jh.*log2(N_Jh+(N_Jh == 0))));
 
% ���
% if strmatch(method,'����Ϣ')
     MuInf = H_A+H_B-H_AB;
% else
%     MuInf = (H_A+H_B)/H_AB;
% end
% disp(H_A);    %4.227
% disp(H_B);    %4.4649
% disp(H_AB);   %7.3196
% disp(MuInf);  %1.3726
