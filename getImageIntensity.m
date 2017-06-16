function [SI,Area] = getImageIntensity(u,image)
%��ȡ����Ȥ��λ��ͼ����Ϣǿ��
% uΪ�ָ��Ķ�ֵͼ�����
% image Ϊԭʼͼ��
s = size(u);
si = zeros(1,8);
area = zeros(1,8);
for k = 1:8
for i = 1:s(2)
    for j = 1:s(1)
        if u(j,i) == 1
            si(k)  = si(k) + double(image(j,i,k));
            area(k) = area(k) + 1;
        else
        end
    end
end
end
Area = area;
SI = si./area;   %ƽ���ź�ǿ��
            
            