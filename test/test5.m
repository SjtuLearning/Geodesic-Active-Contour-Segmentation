%% T2-star��ͨ��ָ��˥���������ʵ�ֵģ�ԭ����˼����ȫ����

%%  �ָ�������ͼ
clc
clear

load matfile\Dimage
load matfile\info
load matfile\Dset1
% imagesc(Image{1});colormap(gray);hold on;
temp = ones(size(Image{1}));

set(gcf,'position',[500 500 144 256]);
imshow(temp,'border','tight','initialmagnification','fit');
hold on;axis off;
axis image
[c0,h0]=contour(u,[0 0],'r');
[c1,h1]=contour(u_0,[0 0],'r');
L = length(c0(1,:));
x0 = c0(1,2:L);
y0 = c0(2,2:L);
w1 = fill(x0,y0,'black');
L1 = length(c1(1,:));
x1 = c1(1,2:L1);
y1 = c1(2,2:L1);
w2 = fill(x1,y1,'w');
f=getframe(gcf);
imwrite(f.cdata,['image\','area.bmp'])
% imwrite(axes,'area1.bmp','bmp');
 % cc = bwconncomp(f);
 % Numpixlong=length(cc.PixelIdxList);
 % stats = regionprops(cc, 'Area' ,'Orientation' ,'MajorAxisLength');
 % stats.Area
%% ������ͼ���ɶ�ֵͼ��
clc
A = imread('image\area.bmp');
t = graythresh(A);
B = im2bw(A,t);
% imshow(B)
%% �����������������
load matfile\Imgsmooth
clc
x0 = 58;
y0 = 128;
r = 50;
h = [];
i = 0;
for theta = 0:1/6*pi:2*pi
    x = x0 + r*cos(theta);
    y = y0 + r*sin(theta);
    i = i+1;
    h(i) = line([x0 x],[y0, y]);  
end
t = i;  
%  set(h(2),'color','r'); %h(1)���ǵ�һ���ߵľ����
%   h��13��Ϊ��һ��ֱ�߾��   ������
T = {};
j = 1;
for i=2:t-1
%     T{j} = getAssMatrix(h(i),h(i+1),Image{1});
    T{j} = getAssMatrix(h(i),h(i+1),Imgsmooth{1});
    j = j+1;
end
%  T{j} = getAssMatrix(h(2),h(i+1),Image{1});
T{j} = getAssMatrix(h(i),h(i+1),Imgsmooth{1});
%  save matfile\h.mat h
%% �ļ��ָ��С����������
sector = {};
si = [];
Area = [];
for i = 1:j
    sector{i} = and(~B,T{i});
% ʹ�ö����δȥ���ͼ��
%     [si(i,:),Area(i,:)] = getImageIntensity(sector{i},Img);
% ʹ�ö����ƽ��ȥ����ͼ��
    [si(i,:),Area(i,:)] = getImageIntensity(sector{i},Imgsmooth);
end
save matfile\si.mat si

%% ������ز���ԥTE��ֵ
te = [];
for i=1:8
    te(i) = info{i}.EchoTime;
end

%% ������������T2*ֵ������������ϵķ�����
clc
load matfile\si
a = [];
t2star = [];
for i= 1:j
    f = @(p,te)p(1)*exp(p(2)*te);
    x0 = [100,-1];
    p = lsqcurvefit(f,x0,te,si(i,:));
    a(i) = p(1);
    t2star(i) = -1/p(2);
end
si(:,9) = t2star;
 f = figure;
 set(f,'position',[100 100 800 500]);
 t = uitable;
 rnames = {};
 for i=1:8
    rnames{i}=['TE' num2str(info{i}.EchoTime)];   
 end
 rnames{9}='T2*';
 set(t,'RowName',rnames,'Data',si');
 set(t,'Position',[100 100 1000 300]);

%% ��ʾѡ�����������
clc
load matfile\Dset1
subplot(121);
imagesc(Image{1});colormap(gray);
hold on;
x0 = 58;
y0 = 128;
r = 50;
% h = [];
% i = 0;
for theta = 0:1/6*pi:2*pi
    x = x0 + r*cos(theta);
    y = y0 + r*sin(theta);
%     i = i+1;
    line([x0 x],[y0, y],'color','r');  
end
contour(u,[0 0],'c');
contour(u_0,[0 0],'c');

t = 12;   %���ò�ͬ�����򣬷�����в���

c=contour(sector{t},[0 0]);
L = length(c(1,:));
fill(c(1,2:L),c(2,2:L),'g');

subplot(122);
SI = si(t,1:8);
t2 = t2star(t);
b = a(t);
T2curve(t2,te,SI,b)



%% �����ʾ���ļ�С�����T2*ֵ��ͼ��ƽ���ź�ǿ��
% % rnames = {};
% % for i=1:8
% %     rnames{i}=['TE' num2str(info{i}.EchoTime)];   
% % end
% % rnames{i+1}='T2*';
% % % subplot(2,2,1:2);
% % 
% % t= uitable;
% % % set(t,'Position',[20 200 300 200])
% % set(t,'RowName',rnames,'Data',si');
% % set(t,'Position',[100 200 1100 300])
% % 
% % %%
% % imagesc(Image{1}); colormap(gray);hold on;
% % contour(u,[0 0],'r');
% % contour(u_0,[0 0],'r');
% % x0 = 58;
% % y0 = 128;
% % r = 50;
% % h = [];
% % i = 0;
% % for theta = 0:1/6*pi:2*pi
% %     x = x0 + r*cos(theta);
% %     y = y0 + r*sin(theta);
% %     i = i+1;
% %     h(i) = line([x0 x],[y0, y],'color','g');  
% % end
% % t = i;
% % % %%   
% % %  set(h(2),'color','r'); %h(1)���ǵ�һ���ߵľ����
% % %   h��13��Ϊ��һ��ֱ�߾��   ������
% % 
% % T = {};
% % j = 1;
% % for i=2:t-1
% %     T{j} = getAssMatrix(h(i),h(i+1),Img{1});
% %     j = j+1;
% % end
% %  T{j} = getAssMatrix(h(2),h(i+1),Img{1});
% % % % u1 = u;
% % % % u2 = u_0;
% % % % u1 = standard(u1);
% % % % u2 = standard(u2);
% % % % u_r = xor(u1,u2);
% % sector = {};
% % si = [];
% % Area = [];
% % for i = 1:j
% %     sector{i} = and(u_r,T{i});
% %     [si(i,:),Area(i,:)] = getImageIntensity(sector{i},Img);
% % end
% % % %%
% 
% % rnames = cell(1,9);
% % for i=1:8
% %     rnames{i}=['TE' num2str(info{i}.EchoTime)];   
% %    % rnames{i}=['TE' num2str(i)]
% % end
% % rnames{9}='T2*';
% % 
% % for i=1:8
% %     te(i) = info{i}.EchoTime;
% % end
% % t2 = [];
% % for k = 1:j
% %     for i=1:7
% %         t2(k,i)= (te(i+1)-te(i))/log(si(k,i)/si(k,i+1));
% %     end
% % end
% % 
% % TE = te(1):2.02:te(7);
% % decay = 200 * exp( -TE/20 ) + 800 * exp( -TE/80 ) + 2.4 
% % y = decay
% % t2star = [];
% % for i = 1:j
% %     t2star(i) = t2(i,:).*y/(t2(i,:)+y);
% % end
% 
% % a = [];
% % for i= 1:j
% %     f = @(p,te)p(1)*exp(p(2)*te);
% %     x0 = [100,-1];
% %     p = lsqcurvefit(f,x0,te,si(i,:));
% %     a(i) = p(1);
% %     t2star(i) = -1/p(2);
% % end
% % si(:,9) = t2star;
% % 
% % rnames = cell(1,9);
% % for i=1:8
% %     rnames{i}=['TE' num2str(info{i}.EchoTime)];   
% %    % rnames{i}=['TE' num2str(i)]
% % end
% % 
% % rnames{9}='T2*';
% % figure
% % t= uitable;
% % % set(t,'Position',[20 200 300 200])
% % set(t,'RowName',rnames,'Data',si');
% % set(t,'Position',[100 200 1100 300])
% %%
% c = 2;
% sect = sector{c};
% SI = si(c,1:8);
% t2 = t2star(c);
% b = a(c);
% T2anlysis(Image{1},u,u_0,sect,te,SI,t2,b)
% 
% 
% %% load set
%  %�����ļ��ָ���
%  load matfile\Dimage
%  load matfile\Gset1
%  load matfile\info
% %%
% 
% f = figure;
% aH = subplot(121);imagesc(Image{1});colormap(gray);hold on;
% contour(u,[0,0],'r');
% contour(u_0,[0,0],'r');
% % a = ginput(2)
% % h1 = line([a(1),a(2)],[a(3),a(4)],'color','r');
% % b = ginput(1);
% % h2 = line([a(1),b(1)],[a(3),b(2)],'color','g');
% [x0 y0] = ginput(1)
% r = 50;
% x1 = x0+r*cos(1/3*pi)
% y1 = y0+r*sin(1/3*pi)
% h1 = line([x0,x1],[y0,y1],'color','r');
% x2 = x0+r*cos(0)
% y2 = y0+r*sin(0)
% h2 = line([x0,x2],[y0,y2],'color','g');
% p0 = [x0 y0]
% DragLine(f,aH,h1);
% DragLine(f,aH,h2);
% % ����ֱ�ߵļн�
% % theta=acosd(dot([x0-x1,y0-y1],[x2-x1,y2-y1])/(norm([x0-x1,y0-y1])*norm([x0-x1,y2-y1])))
% %% ������������򣬽�����������ʹ�þ���洢
% xdata_start1=get(h1,'xdata')   %��ȡ��ǰֱ�ߵ�����
% ydata_start1=get(h1,'ydata')
% xdata_start2=get(h2,'xdata')
% ydata_start2=get(h2,'ydata')
% p1 = [xdata_start1(2) ydata_start1(2)]
% p2 = [xdata_start2(2) ydata_start2(2)]
% 
% T = zeros(size(Image{1}));
% % %��ֱ��б�ʵķ����ı׶�̫�࣬������������ȷ�
% % k1=(y0-y1)/(x0-x1)  %���ܴ���б�ʲ����ڵ����������ν��
% % k2=(y1-y2)/(x1-x2)
% % k3=(y2-y0)/(x2-x0)  
% % line1 = k1*(x-x0)+y0;
% % line2 = k2*(x-x1)+y1;
% % line3 = k3*(x-x0)+y0;
% xmax = ceil(max(max(p0(1),p1(1)),p2(1)))
% xmin = floor(min(min(p0(1),p1(1)),p2(1)))
% ymax = ceil(max(max(p0(2),p1(2)),p2(2)))
% ymin = floor(min(min(p0(2),p1(2)),p2(2)))
% for x=xmin:1:xmax
%     for y=ymax:-1:ymin
%         p=[x y];
%         t = IsInTriangleArea(p,p0,p1,p2);
%         if t==1
%             T(y,x)=1;
%         end
%     end
% end
% % find(T == 1)
% subplot(122);
% imshow(T)
% % for x = xmin:1:xmax
% %     for y = ymin:1:ymax
% %         if y==fix(k1*(x-x0)+y0)||...
% %                 y==fix(k2*(x-x1)+y1)||...
% %                 y==fix(k3*(x-x0)+y0)   %�����һ��ֱ�߷���
% %            T(y,x) = 1; 
% %         end
% %         
% %     end
% % end
% % % imshow(T)
% % i = 1;
% % t = [];
% % for y=ymax:-1:ymin
% %     for x=xmin:1:xmax
% %         if T(y,x)==1
% %             t(i) = x;    %Ϊʲô�����ˣ���������t[]���������ֵ�����
% %             i = i+1;
% %         end
% %     end
% %     tmin = min(t)
% %     tmax = max(t)
% %     T(y,tmin:tmax)=1;
% % %     i = 1;        
% % end
% %  imshow(T)
% % ��������������жϡ�ԭ��������p1,p2,p3,�µ�p. 
% % ���(s(p,p1,p2)+s(p,p1,p3)+s(p,p3,p2))=s(p1,p2,p3) 
% % p�����ڲ� 
% % �ж������붨����ڽ�֮���Ƿ����2Pi
% % p=1/2(a+b+c) 
% % s=sqrt(p*(p-a)(p-b)(p-c))
% % p0 = [x0,y0];   %�÷���Ҳ������,������7.30���
% % p1 = [x1,y1];
% % p2 = [x2,y2];
% % hold on;
% % line([p0(1),p1(1)],[p0(2),p1(2)],'color','r');
% % line([p0(1),p2(1)],[p0(2),p2(2)],'color','g');
% %%
% u1 = u;
% u2 = u_0;
% u1 = standard(u1);
% u2 = standard(u2);
% u_r = xor(u1,u2);
% sector = and(u_r,T);
% % sector = getSectorArea(u_r,a,b);
% 
% % DragLine(f,aH,h1);
% % %% imshow(sector)
% A = Image{1};
% B = drawSector(A,sector);
% imagesc(B);colormap(gray);
% axis off;
% hold on;
% contour(u,[0,0],'r');
% contour(u_0,[0,0],'r');
% % line([a(1),a(2)],[a(3),a(4)],'color','r');
% % line([a(1),b(1)],[a(3),b(2)],'color','g');
% line([p0(1),p1(1)],[p0(2),p1(2)],'color','r');
% line([p0(1),p2(1)],[p0(2),p2(2)],'color','g');
%  %% ���ͼ���ƽ��ǿ��
% [si,Area] = getImageIntensity(sector,Image);
% 
% % [si,Area] = getImageIntensity(u_r,Image);
% si
%  %% T2* analysis
% 
% te = zeros(1,8);
% for i=1:8
%     te(i) = info{i}.EchoTime;
% end
% t2 = [];
% for i=1:7
%     t2(i)= (te(i+1)-te(i))/log(si(i)/si(i+1));
% end
% % TE = 2.6:2.02:15
% 
% % test 1 
% % { ���������˥���������벻����
% % y = zeros(1,7);
% % s = 0;
% % for i=1:7
% %     y(i) =s + 1.5*(si(i)-si(i+1))*exp(-te(i+1)/t2(i))
% %     s = s+y(i);
% % end
% % }%
% 
% %  te = 10:10:320;
%  TE = te(1):2.02:te(7);
%  decay = 200 * exp( -TE/20 ) + 800 * exp( -TE/80 ) + 2.4; 
%  noise_factor = 10;
%  decay = decay + 5*randn( size ( decay ) ) ;
% % %Generate Basis Values
% % ��8��TEֵ��
%  T2min = min(t2); 
%  T2max = max(t2); 
%  T2length = 7;
%  T2Times = logspace( log10 ( T2min ) , log10 ( T2max ) , T2length );
%  T2Basis = exp(-kron( TE', 1./T2Times ) );   %T2'(T2 prime) ???
%  [ amplitudes , mu ] = CVNNLS( T2Basis , decay' ) ;
% %  semilogy(te , decay , 'ko ' , te , y_recon , 'b' )
% % y  = 50 * exp(-te./8 ) + 700 * exp(-te./100) + ...
% %         0 * exp( -te./1000 );  %˥������
% % y  = 50 * exp(-TE./8 ) + 700 * exp(-TE./100) + ...
% %          0 * exp( -TE./1000 );  %˥������
% % decay = 200 * exp( -te/20 ) + 800 * exp( -te/80 ) + 2.4
% % t2b = exp(-kron( te', 1./t2 ) )
% % t2 =(t2(2)*detT)/(T2(2)+detT)
% % ˥��������ʲô��������
%  y_recon =  T2Basis*amplitudes;
% %  t2star = t2.*y/(t2+y)
%  y = y_recon;
%  t2star = t2.*y'/(t2+y')
% % SNR = 2000
% 
% % y_e = y + y(1)/SNR*randn(size(y))  %���������˥������
% % 
% %%
% 
% % te = 2.6:2.02:17;
% % p = polyfit(te,si,3);
% % x = 0:.1:20;
% % y = polyval(p,x);
% % subplot(122);plot(te,si,'*',x,y);
% % axis([0 20 0 180]); %����������ķ�Χ
% % xlabel('TE','color','r');
% % ylabel('SI','color','r');
% % grid on
% %%
% si(9) = t2star;
% rnames = cell(1,9);
% for i=1:8
%     rnames{i}=['TE' num2str(info{i}.EchoTime)];   
%    % rnames{i}=['TE' num2str(i)]
% end
% rnames{9}='T2*';
% % p=subplot(2,2,1:2);
% % position= get(p,'Position');
% figure;
% t = uitable;
% % set(t,'Position',[20 200 300 200])
% set(t,'RowName',rnames,'Data',si','ForegroundColor','r');  %Ϊ�β�����ȫ��ʾ������
% %%
% % plot(1:10);set(gca,'yscale','log');
% % disp('�밴��Enter��');
% % pause
% % set(gca,'Yscale','linear');
% 
% 
% % area = getSectorArea(u_r,a,b);
% % imshow(area);
% % set(h,'FaceColor',[1 1 1])
% % imshow(h)
% % sector = getSectorArea(u_r,a,b);
% % % pause
% % [x1,y1] = ginput(1);
% % h = line([x(1),x1],[y(1),y1],'color','g')
% % set(h,'color','w')
% % segment(u_r,6);
% % get(gca);
% % delete(h)   %ɾ��ֱ��
% % h = get(gca,'Children')
% % get(h,'type');
% % h_i = findobj(h,'Type','image');
% % h_l = findobj(h,'Type','line');
% % set(h_l(1:2),'color','g');
% % % pause;
% % get(gcf,'currentobject')
% % 
% % figure;
% % set(h_i,'color','r')
% % imshow()
% 
% 
% % A = findobj(gca,'Type','line','-and','Type','image')
% % set(A,'color','g');
% % 
% % BW = edge(u_r,'sobel','r');
% % axe_handle = get(gca)
% f = figure('Position',[200 200 400 150]);
% dat = rand(3); 
% cnames = {'X-Data','Y-Data','Z-Data'};
% rnames = {'First','Second','Third'};
% t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
%             'RowName',rnames,'Position',[20 20 360 100]);
%  
%  
%  



