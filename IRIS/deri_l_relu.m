function out = deri_l_relu(in, a)
	
	if in > 0
		out = 1;
	else 
		out = a;
	end
end
