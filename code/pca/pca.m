allsamples=[];%所有训练图像 
for i=1:40    
    for j=1:5        
        a=imread(strcat('E:\学习\第二学期\机器学习（潘）\PCA\att_faces\s',num2str(i),'\',num2str(j),'.pgm'));                         
        b=a(1:112*92); % b是行矢量 1×N，其中N＝10304，提取顺序是先列后行，即从上到下，从左到右        
        b=double(b);        
        allsamples=[allsamples; b];  % allsamples 是一个M * N 矩阵，allsamples 中每一行数据代表一张图片，其中M＝200   
    end
end
samplemean=mean(allsamples); % 平均图片，1 × N  
figure%平均图
imshow(mat2gray(reshape(samplemean,112,92)));
for i=1:200 
    xmean(i,:)=allsamples(i,:)-samplemean; % xmean是一个M × N矩阵，xmean每一行保存的数据是“每个图片数据-平均图片” 
end
sigma=xmean*xmean'; % M * M 阶矩阵 
[v,d]=eig(sigma);
d1=diag(d); 
[d2,index]=sort(d1); %以升序排序 
cols=size(v,2);% 特征向量矩阵的列数

for i=1:cols      
    vsort(:,i) = v(:, index(cols-i+1) ); % vsort 是一个M*col(注:col一般等于M)阶矩阵，保存的是按降序排列的特征向量,每一列构成一个特征向量      
    dsort(i)   = d1( index(cols-i+1) );  % dsort 保存的是按降序排列的特征值，是一维行向量 
end  %完成降序排列 %以下选择90%的能量 
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
title('前n个特征特占总的能量百分比');
xlabel('前n个特征值');
ylabel('占百分比');
figure
plot(a,dsort/dsum,'linewidth',2);
grid
title('第n个特征特占总的能量百分比');
xlabel('第n个特征值');
ylabel('占百分比');
i=1;  % (训练阶段)计算特征脸形成的坐标系
while (i<=p && dsort(i)>0)      
    base(:,i) = dsort(i)^(-1/2) * xmean' * vsort(:,i);   % base是N×p阶矩阵，除以dsort(i)^(1/2)是对人脸图像的标准化，特征脸
      i = i + 1; 
end   % add by wolfsky 就是下面两行代码，将训练样本对坐标系上进行投影,得到一个 M*p 阶矩阵allcoor  
figure%显示前20个特征脸
 for i=1:20
  b=reshape(base(:,i)',112,92);%
  subplot(4,5,i);
  imshow(mat2gray(b));
 end



