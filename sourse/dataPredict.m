function p = dataPredict(Theta1, Theta2, X)
% ���룺Ȩֵtheta1 theta2�����Լ�X
% ���أ��������y

% ������ʼ��
m = size(X, 1);
num_labels = size(Theta2, 1);

% ǰ�򴫲�
p = zeros(size(X, 1), 1);
h1 = Sigmoid([ones(m, 1) X] * Theta1');
h2 = Sigmoid([ones(m, 1) h1] * Theta2');

% ȡ���ֵ��ΪԤ��ֵ
[~, p] = max(h2, [], 2);

end
