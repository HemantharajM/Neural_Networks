function out = deri_elu(in, a)
	if in >= 0
		out = 1;
	else
		out = a * exp(in);
	end
end

