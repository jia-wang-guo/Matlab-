allsamples=[];%����ѵ��ͼ�� 
for i=1:40    
    for j=1:5        
        a=imread(strcat('E:\ѧϰ\�ڶ�ѧ��\����ѧϰ���ˣ�\PCA\att_faces\s',num2str(i),'\',num2str(j),'.pgm'));                         
        b=a(1:112*92); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������        
        b=double(b);        
        allsamples=[allsamples; b];  % allsamples ��һ��M * N ����allsamples ��ÿһ�����ݴ���һ��ͼƬ������M��200   
    end
end
samplemean=mean(allsamples); % ƽ��ͼƬ��1 �� N  
figure%ƽ��ͼ
imshow(mat2gray(reshape(samplemean,112,92)));
for i=1:200 
    xmean(i,:)=allsamples(i,:)-samplemean; % xmean��һ��M �� N����xmeanÿһ�б���������ǡ�ÿ��ͼƬ����-ƽ��ͼƬ�� 
end
sigma=xmean*xmean'; % M * M �׾��� 
[v,d]=eig(sigma);
d1=diag(d); 
[d2,index]=sort(d1); %���������� 
cols=size(v,2);% �����������������

for i=1:cols      
    vsort(:,i) = v(:, index(cols-i+1) ); % vsort ��һ��M*col(ע:colһ�����M)�׾��󣬱�����ǰ��������е���������,ÿһ�й���һ����������      
    dsort(i)   = d1( index(cols-i+1) );  % dsort ������ǰ��������е�����ֵ����һά������ 
end  %��ɽ������� %����ѡ��90%������ 
dsum = sum(dsort);     
dsum_extract = 0;   
p = 0;     
while( dsum_extract/dsum < 0.97)       
    p = p + 1;          
    dsum_extract = sum(dsort(1:p));     
end
a=1:1:200;
for i=1:1:200
y(i)=sum(dsort(a(1:i)) );
end
figure
y1=ones(1,200);
plot(a,y/dsum,a,y1*0.9,'linewidth',2);
grid
title('ǰn��������ռ�ܵ������ٷֱ�');
xlabel('ǰn������ֵ');
ylabel('ռ�ٷֱ�');
figure
plot(a,dsort/dsum,'linewidth',2);
grid
title('��n��������ռ�ܵ������ٷֱ�');
xlabel('��n������ֵ');
ylabel('ռ�ٷֱ�');
i=1;  % (ѵ���׶�)�����������γɵ�����ϵ
while (i<=p && dsort(i)>0)      
    base(:,i) = dsort(i)^(-1/2) * xmean' * vsort(:,i);   % base��N��p�׾��󣬳���dsort(i)^(1/2)�Ƕ�����ͼ��ı�׼����������
      i = i + 1; 
end   % add by wolfsky �����������д��룬��ѵ������������ϵ�Ͻ���ͶӰ,�õ�һ�� M*p �׾���allcoor  
figure%��ʾǰ20��������
 for i=1:20
  b=reshape(base(:,i)',112,92);%
  subplot(4,5,i);
  imshow(mat2gray(b));
 end



