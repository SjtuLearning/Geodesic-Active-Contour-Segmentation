function h = Jointh_My(image1,image2)
%   JOINTH_MY    ͳ��ͼ��image1��image2������ֱ��ͼ
%   ���ߣ�lskyp    2009.07.23
%   �汾��V1.0
[rows,cols] = size(image1);
if class(image1) == 'double'
    h = zeros(256,256);
    image1 = int8(image1);
    image2 = int8(image2);
elseif class(image1) == 'int8'
    h = zeros(256,256);
elseif class(image1) == 'int16'
    h = zeros(256,256);
    image1 = int8(image1);
    image2 = int8(image2);
end
for k = 1:rows
    for l = 1:cols
        h(image1(k,l)+1,image2(k,l)+1) = h(image1(k,l)+1,image2(k,l)+1)+1; % ��������ֱ��ͼ
    end
end    