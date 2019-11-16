function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% X = (d,k)
% W = (d, n)

% Replace the following line with your implementation.
%output.data = zeros([n, k]);

%size(input.data)
%size(param.w)
%size(param.b)

output.data = (input.data' * param.w  + param.b)';

%size(output.data)
output.width = input.width;
output.height = n;
output.channel = input.channel;
output.batch_size = input.batch_size;

end
