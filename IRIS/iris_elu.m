%load the data and separate the training and test data as 90:10
data = load('./data/iris.data');
M = length(data);

No_of_train = 5;
indices = randperm(50,No_of_train);
Test_data = data(indices,:);
Test_data = [Test_data; data(indices+50, :)];
Test_data = [Test_data ; data(indices+100, :)];

data(indices+100, :) = [];
data(indices+50, :) = [];
data(indices, :) = [];
Train_data = data;


%set the input and output
m = length(data);
X = [ones(m,1) Train_data(:, 1:4)]; 
y = Train_data(:,5);

%Normalize the data
mean_X = mean(X(:,2:5));
std_X = std(X(:,2:5));
X(:,2:5) = (X(:,2:5) - mean_X) ./ std_X;

%change the Y to multivariable
Y = zeros(m,3);
for i=1:m
	if y(i) == 1
		Y(i,:) = [1 0 0];
	elseif y(i) == 2
		Y(i,:) = [0 1 0];
	else
		Y(i,:) = [0 0 1];
	end
end

%Initialize the architecture of Neural Network
input_node = 4 + 1;
output_node = 3;
hidden_layer = 1;
hidden1_node = 5;

W1 = rand(hidden1_node,input_node);
W2 = rand(output_node,hidden1_node+1);

a = 0.001;
for j=1:5500
	Delta2 = zeros(output_node,hidden1_node + 1);
	Delta1 = zeros(hidden1_node,input_node);
	for i=1:m
		a1 = X(i,:)';
		z2 = W1*(a1);
		a2_ = deri_elu(z2, a);
		a2 = elu(z2,a);
		a2 = [1; a2];
		z3 = W2 * a2 ;
		a3 = elu(z3,a);
	
		delta3 = (a3 - Y(i,:)');
		delta2 = (W2(:,2:6)' * delta3) .* ((a2_));

		Delta2 = Delta2 + (delta3 * (a2'));
		Delta1 = Delta1 + (delta2 * (a1)');

	end
	
	W1 = W1 - (0.0001) .* Delta1;
	W2 = W2 - (0.0001) .* Delta2;
end

%check the prediction accuracy from the Test data

total_no = 0;
correct_no = 0;

test_data(:,1:4) = (Test_data(:,1:4) - mean_X) ./ std_X;
for i =1:15
	a1 = [1 test_data(i,1:4)]';
	z2 = W1 * a1;
	a2 = elu(z2,a);
	a2 = [1;a2];
	z3 = W2 * a2;
	a3 = elu(z3,a);

	[val, indices] = max(a3);	
	if Test_data(i,5)  == indices 
		correct_no = correct_no + 1;
	end
	total_no = total_no + 1;
	fprintf('For the data %f %f %f %f original ouput is %f and predicted output is %f %f %f\n', Test_data(i,1:4), Test_data(i,5), a3');
end

fprintf('Prediction accuracy is %f\n', (correct_no / total_no) * 100); 
