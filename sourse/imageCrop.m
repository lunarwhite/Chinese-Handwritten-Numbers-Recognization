function bw2 = imageCrop(bw,~)

% �ҵ�ͼ��߽磬��ȡ�߽�
[y2temp, x2temp] = size(bw);
x1=1;
y1=1;
x2=x2temp;
y2=y2temp;

flag=30;

% ���
cntB=1;
while (sum(bw(:,cntB))<=flag)

    x1=x1+1;
    cntB=cntB+1;
end
 
% �ұ�
cntB=1;
while (sum(bw(cntB,:))<=flag)
   y1=y1+1;
   cntB=cntB+1;
end
 
% �ϱ�
cntB=x2temp;
while (sum(bw(:,cntB))<=flag)
   x2=x2-1;
   cntB=cntB-1;
end
 
% �±�
cntB=y2temp;
while (sum(bw(cntB,:))<=flag)
   y2=y2-1;
   cntB=cntB-1;
end

% �ü�
bw2=imcrop(bw,[x1,y1,(x2-x1),(y2-y1)]);

end
