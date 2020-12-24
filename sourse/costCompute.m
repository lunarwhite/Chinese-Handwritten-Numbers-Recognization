function [J, grad] = costCompute(nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)

Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));

% mΪѵ����������
m = size(X, 1);
         
% ����Ȩֵ������ݶȣ����ۺ����ĳ�ʼ��
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ��ʼ�����ȱ���
yNum = zeros(m, num_labels);

% ת�����ȱ���
for i = 1:m
  yNum(i, y(i)) = 1;
end

% ��ʼѵ��
a1 = X;

% ��һ�����ļ���
z2 = (Theta1 * [ones(m, 1) a1]')';
a2 = Sigmoid(z2);

% �ڶ������ļ���
z3 = (Theta2 * [ones(m, 1) a2]')';
a3 = Sigmoid(z3);

for i = 1:m
  J = J + (-yNum(i, :) * log(a3(i, :))' - (1.- yNum(i, :)) * log(1.- a3(i, :))');%ǰ�򴫲��Ĺ���
end

J = J / m;

%���򻯷�ֹ�����
t1 = Theta1(:, 2:end);
t2 = Theta2(:, 2:end);

%������
regularization = lambda / (2 * m) * (sum(sum(t1 .^ 2)) + sum(sum(t2 .^ 2)));
J = J + regularization;

% ���򴫲�
d3 = a3-yNum;

d2 = (d3 * Theta2(:, 2:end)) .* SigmoidGradient(z2);

a2_with_a0 = [ones(m, 1) a2];
D2 = d3' * a2_with_a0;

%Theta2�ݶ�
Theta2_grad = D2 / m;

%������
regularization = lambda / m * [zeros(size(Theta2, 1), 1) Theta2(:, 2:end)];
Theta2_grad = Theta2_grad + regularization;

% 200 x 401 Theta1_grad
a1_with_a0 = [ones(m, 1) a1];
D1 = d2' * a1_with_a0;
Theta1_grad = D1 / m;
regularization = lambda / m * [zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
Theta1_grad = Theta1_grad + regularization;

% ���ݶȷ���һ����������
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
