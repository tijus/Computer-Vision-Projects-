imRed= [];
lRed = load("../data/red.mat");

imRed = lRed.red;
subRed = imRed(277:533,344:600);
%% SSD implementation
row = 277;
col = 344;
fssd = 10000000000000;
for i=row-30:1:row+30
    for j=col-30:1:col+30
        b = imRed(i:256+i,j:256+j)-subRed;
        c = b.^2;
        d = sum(sum(c));  
        if d<fssd
            fssd = d;
            row1 = i;
            col1 = j;
        end            
    end
end














        