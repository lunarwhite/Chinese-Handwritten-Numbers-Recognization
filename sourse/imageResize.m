function lett = imageResize(bw2)
% ��ȡ������ת��20*20������ʸ��,��ͼ����ÿ10*10�ĵ���л�����ӣ�������ӳ�һ����
% ��ͳ��ÿ��С������ͼ��������ռ�ٷֱ���Ϊ��������

% ��ʵ������ȡ����������ͼƬ����

bw_2020=imresize(bw2,[200,200]);

for cnt=1:20
   for cnt2=1:20
       data_temp=bw_2020(((cnt*10-9):(cnt*10)),((cnt2*10-9):(cnt2*10)));
       atemp=sum(data_temp);
       lett((cnt-1)*20+cnt2)=sum(atemp);
   end
end

lett=lett';

end

