function result = rec(imagepath,eignface,meanface)
picture=imread(imagepath);
vpicture=picture(1:112*92); % b����ʸ�� 1��N������N��10304����ȡ˳�������к��У������ϵ��£�������        
vpicture=double(vpicture); %��ͼƬ����������
evalue=vpicture*eignface;%�õ�һ������ֵ��������1*71
output=zeros(1,10304);
for i=1:71
  output=output+(evalue(i))*eignface(:,i);
end
output=output+meanface;
outputp=reshape(output',112,92);
imshow(uint8(outputp));
end

