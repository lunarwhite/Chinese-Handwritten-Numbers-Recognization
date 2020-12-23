function gradientCheck(lambda)
% ����һ������������ݶȼ��
% ��ʹ���ݶȼ����ʱ�򣬾���ʹ��С��NN�������������������뵥Ԫ�����ص�Ԫ����˲���Ҳ��Խ���
% ��ȷ���ݶȼ���׼ȷʱ���ر��ݶȼ���
% from: Andrew Ng's exercises
disp('����[��ֵ�ݶ�][�����ݶ�]');

if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

input_layer_size = 3;
hidden_layer_size = 5;
num_labels = 3;
m = 5;

Theta1 = weightInitDebug(hidden_layer_size, input_layer_size);
Theta2 = weightInitDebug(num_labels, hidden_layer_size);
X  = weightInitDebug(m, input_layer_size - 1);
y  = 1 + mod(1:m, num_labels)';

nn_params = [Theta1(:) ; Theta2(:)];

costFunc = @(p) costCompute(p, input_layer_size, hidden_layer_size, ...
                               num_labels, X, y, lambda);

[~, grad] = costFunc(nn_params);
numgrad = gradientCompute(costFunc, nn_params);

disp([numgrad grad]);

disp('check1--������ֵ�Ƿ�ǳ��ӽ�');

disp('����[Relative Difference]');

diff = norm(numgrad-grad)/norm(numgrad+grad);
fprintf('%g\n\n', diff);

disp('check2--��ֵ�Ƿ�С�� 1e-9');

end