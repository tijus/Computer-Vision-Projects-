function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A

A = (inv(A(: , :)));
disp(A);
%[row col dim] = size(A);
new_image = zeros(out_size(1), out_size(2));
for i=1:1:out_size(1)
    for j=1:1:out_size(2)
        x = round((i)*A(1,1) + (j)*A(2,1) - A(1,3));
        y = round((i)*A(1,2) + (j)*A(2,2) - A(2,3));
        %Subscript indices must either be real positive integers or logicals.
        if(x>0 && y>0 && x<=out_size(1) && y<=out_size(2))
            new_image(i,j)= im(x,y);
        end
    end
end
warp_im = new_image(1:200, 1:150);
end
