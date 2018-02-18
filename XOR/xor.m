X = [1 1 1 1; 0 0 1 1; 0 1 0 1];
Y = [ 0; 1 ; 0; 1];

W1 = rand(3,3);
W2 = rand(1,4);

W1_velocity = zeros(3,3);
W2_velocity = zeros(1,4);

momentum = 0.9;

for j=1:100
	Delta2 = zeros(1,4);
	Delta1 = zeros(3,3);
	for i=1:4
		a1 = X(:,i);
		z2 = W1*(a1);
		a2 = sigmoid(z2);
		a2 = [1; a2];
		z3 = W2 * a2 ;
		a3 = sigmoid(z3);
	
		delta3 = (a3 - Y(i,1))
		delta2 = (W2(2:4)' * delta3) .* (a2(2:4) .* (1 - a2(2:4)));

		Delta2 = Delta2 + (delta3 * (a2'));
		Delta1 = Delta1 + (delta2 * (a1)');

	end
	
	W1_velocity =momentum * W1_velocity - (0.1) .* Delta1;
	W2_velocity = momentum * W2_velocity - (0.1) .* Delta2;
	W1 = W1 + W1_velocity ;
	W2 = W2 + W2_velocity;
end
