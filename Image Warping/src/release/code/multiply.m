%defining the source matrix
A = [1 2 3 4 5 6; 2 3 4 5 6 7; 3 4 5 6 7 8; 4 5 6 7 8 9 ];

% defining the multiplier matrix
B=[ 1 2; 3 5; 5 6];
[row col dim] = size(A);
[r c d] = size(B);
for i=1:1:row
    %fprintf("%d\n",i);
    for j=1:1:col
     %   fprintf("%d\n",i);
        %%code for multiplication
        C = B*A(i:i+2,:);
    end
end