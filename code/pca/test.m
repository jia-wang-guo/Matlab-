allcoor = allsamples * base; accu = 0;   % 测试过程

for i=1:40     
    for j=6:10 %读入40 x 5 副测试图像         
        a=imread(strcat('E:\学习\第二学期\机器学习（潘）\PCA\att_faces\s',num2str(i),'\',num2str(j),'.pgm'));       
        b=a(1:10304);        
        b=double(b);        
        tcoor= b * base; %计算坐标，是1×p阶矩阵      
        for k=1:200                 
            mdist(k)=norm(tcoor-allcoor(k,:));        
        end          %三阶近邻   
        [dist,index2]=sort(mdist);          
        class1=floor( index2(1)/5 )+1;      
        class2=floor(index2(2)/5)+1;        
        class3=floor(index2(3)/5)+1;        
        if class1~=class2 && class2~=class3 
            class=class1;         
        elseif class1==class2          
            class=class1;         
        elseif class2==class3     
            class=class2;         
        end         
        if class==i      
            accu=accu+1;        
        end   
    end
end  
accuracy=accu/200 %输出识别率
