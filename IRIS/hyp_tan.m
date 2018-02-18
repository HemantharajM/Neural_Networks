function out = hyp_tan(in)
	
	out = (1 - exp(-in .* 2)) ./ ( 1 + exp(-in .* 2));

end
