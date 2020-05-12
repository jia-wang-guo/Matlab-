function result = rec(imagepath,eignface,meanface)
picture=imread(imagepath);
vpicture=picture(1:112*92); % b是行矢量 1×N，其中N＝10304，提取顺序是先列后行，即从上到下，从左到右        
vpicture=double(vpicture); %把图片拉成行向量
evalue=vpicture*eignface;%得到一组特征值，个数是1*71
output=zeros(1,10304);
for i=1:71
  output=output+(evalue(i))*eignface(:,i);
end
output=output+meanface;
outputp=reshape(output',112,92);
imshow(uint8(outputp));
end

