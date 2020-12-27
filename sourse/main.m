%% ׼����������չ�����
clear; 
close all; 
clc;
newline;

%% ׼�����������벢Ԥ����data
disp('����>���ݵ���ing...');
path_data = 'D:\MEDESKTOP\089\group089--project2\data2\handwritingPictures\';

files = dir(fullfile(path_data,'*.jpg'));
m = length(files);
n = 400;

y = zeros(m, 1);
X = zeros(m, n);

for i = 1 : m
    Img = imread(strcat(path_data,files(i).name));        

    Img = imageCrop(Img);
    Img = imbinarize(Img,0.1);
    Img = imcomplement(Img);
    Img = imageResize(Img);
    Img = reshape(Img,20,20);

    kkk = strsplit(files(i).name, {'_', '.'});
    id = str2double(cell2mat(kkk(4)));
    y(i, :) = id;
    X(i, :) = (Img(:))';
end

for i = 1 : m
    minn = min(X(i, :));
    meann = mean(X(i,:));
    maxx = max(X(i, :));
    X(i, :) = (X(i, :) - meann) / (maxx - minn);
end

R = randperm(m);
num_train = 10000;

X_train = X(R(1:num_train), :);
y_train = y(R(1:num_train), :);

R(1:num_train) = [];

X_test = X(R, :);
y_test = y(R, :);

disp('����>��ɣ�');
fprintf('\n\n');

disp('����>����Ԥ����ing...');
m = size(X_train, 1);

% disp('@Ԥ�������ͼƬ���ӻ����μ�figure��');
% a = size(X_train,1);
% sel = randperm(a);
% sel = sel(1:900);
% dataView(X_train(sel, :));

disp('����>��ɣ�');
fprintf('\n\n');

%% ׼������������Ȩֵ����
disp('����>Ȩֵ��������ing...');
L_out1=200;
L_in1=400;
L_out2=15;
L_in2=200;

% ��ʼ��Theta
Theta1 = zeros(L_out1, 1 + L_in1);
Theta2 = zeros(L_out2, 1 + L_in2);

% �����ʼ��Theta��ʹ�������̬�ֲ�
Theta1 = weightInit(L_in1, L_out1);
Theta2 = weightInit(L_in2, L_out2);

% save('weight.mat','Theta1','Theta2');

% load('weights.mat');%����Ȩֵ����theta1��theta2

nn_params = [Theta1(:) ; Theta2(:)];%���һ��

disp('����>��ɣ�');
fprintf('\n\n');

%% �����磬ǰ�򴫲�����

% ����������Ԫ���������룬���
input_layer_size  = 400;  % 20*20
hidden_layer_size =200;   % 200��������Ԫ
num_labels = 15;          % 15����ǩ����ʾ�㵽��

disp('@ǰ�򴫲�')

% ���������򻯳�����lambdaΪ0
lambda = 0;
% ��һ��������Ȩֵ���󣬵ڶ�����������������Ԫ����400��
% �������������������Ԫ����200�����ĸ�����������ĸ�����
% X�����������y�Ǳ�ǩ�������Ƕ��������ʽ����1,2,3,4...����ʽ��lambda�����򻯳���
J = costCompute(nn_params, input_layer_size, hidden_layer_size, num_labels, X_train, y_train, lambda);

fprintf('�������J: %f\n\n\n', J);

%% �����磬�������
disp('@�������1');

% ���Ƚ�����ǰ��ĳ������ó�1.
lambda = 1;
J = costCompute(nn_params, input_layer_size, hidden_layer_size, num_labels, X_train, y_train, lambda);

fprintf('�������J: %f\n\n\n', J);

%% �����磬�����ʼ��Ȩֵ
disp('����>�����ʼ��Ȩֵing...');

initial_Theta1 = weightInit(input_layer_size, hidden_layer_size);
initial_Theta2 = weightInit(hidden_layer_size, num_labels);

% ����һ��������
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

disp('����>��ɣ�');
fprintf('\n\n');

%% �����磬���򴫲��ݶȼ���
disp('����>���򴫲��ݶȼ���ing...');

gradientCheck;
disp('����>��ɣ�');
fprintf('\n\n');

%% �����磬��ӷ��򴫲�����
disp('@�������2');

lambda = 0.01;
% gradientCheck(lambda);
debug_J  = costCompute(nn_params, input_layer_size, hidden_layer_size, num_labels, X_train, y_train, lambda);

% ��lambda�ķ��򴫲�����
fprintf('����J: %f\n\n', debug_J);

%% �����磬ѵ��
disp('����>������ѵ��ing...');

% �������򻯳�����
numinput1 = input('-->���������򻯳����������س��ύ��');
lambda = numinput1;

% ���õ�������
numinput2 = input('-->������������������س��ύ��');
Iterations = numinput2;

options = optimset('MaxIter', Iterations);

% һ�ε���
costFunction = @(p) costCompute(p, input_layer_size, hidden_layer_size, num_labels, X_train, y_train, lambda);

% ��������
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% ѵ���õ�Theta1��Theta2
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));

disp('����>��ɣ�');
fprintf('\n\n');

%% �����磬Ȩֵ���ӻ����м��������ӻ�
% disp('@Ȩֵ���ӻ����μ�figure��');
% dataView(Theta1(:, 2:end));
% fprintf('\n\n');

%% ����ģ�ͣ�����׼ȷ��
disp('@ģ��׼ȷ��');

thisPrediction1 = dataPredict(Theta1, Theta2, X_train);
thisPrediction2 = dataPredict(Theta1, Theta2, X_test);
acc_train=mean(double(thisPrediction1 == y_train));
acc_test= mean(double(thisPrediction2 == y_test));
fprintf('����>��ѵ�����ϵı��֣� %f\n', acc_train);
fprintf('����>�ڲ��Լ��ϵı��֣� %f\n\n', acc_test);

disp('����>��ʾ������thanks~~');