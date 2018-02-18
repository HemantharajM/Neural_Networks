function out = elu(in,a)
	if in >= 0
		out = in;
	else
		out = a * (exp(in) - 1);
	end
end
