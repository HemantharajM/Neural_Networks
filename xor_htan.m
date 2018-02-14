X = [1 1 1 1; 0 0 1 1; 0 1 0 1];
Y = [ 0; 1 ; 0; 1];

W1 = rand(3,3);
W2 = rand(1,4);


for j=1:1000
	Delta2 = zeros(1,4);
	Delta1 = zeros(3,3);
	for i=1:4
		a1 = X(:,i);
		z2 = W1*(a1);
		a2 = hyp_tan(z2);
		a2 = [1; a2];
		z3 = W2 * a2 ;
		a3 = hyp_tan(z3);
	
		delta3 = (a3 - Y(i,1))
		delta2 = (W2(2:4)' * delta3) .* ((1 - (a2(2:4).^2)));

		Delta2 = Delta2 + (delta3 * (a2'));
		Delta1 = Delta1 + (delta2 * (a1)');

	end
	
	W1 = W1 - (0.1) .* Delta1;
	W2 = W2 - (0.1) .* Delta2;
end
