function [X_Coordinates,Y_Coordinates,Z_Coordinates] = Coordinate_Estimate(sp3_file)
[sat] = read_sp3file(sp3_file);
for q = 1:32
    satellite = sat(:,:,q);
    for z = 1:3
        axis = satellite(:,z);
     for  j = 1:96
        estimated(j*3-2) = axis(j);
     end
    for i = 1:length(axis)*3-2
    a = round(i/3);
    k = a*3-2;
    if (i/3-a)~=1/3
        if a<=6
            d = [axis(1) axis(2) axis(3) axis(4) axis(5) axis(6) axis(7) axis(8) axis(9) axis(10)];
            f = [1 4 7 10 13 16 19 22 25 28];
            d0 = i;
            f0 = lagrange_interp(f, d, d0);
            estimated(i) = f0;
        elseif a>6&&a<92
            d = [axis(a-5) axis(a-4) axis(a-3) axis(a-2) axis(a-1) axis(a+1) axis(a+2) axis(a+3) axis(a+4) axis(a+5)];
            f = [(k-15) (k-12) (k-9) (k-6) (k-3) (k+3) (k+6) (k+9) (k+12) (k+15)];
            d0 = i;
            f0 = lagrange_interp(f, d, d0);
            estimated(i) = f0;
        elseif 92<=a
            d = [axis(87) axis(88) axis(89) axis(90) axis(91) axis(92) axis(93) axis(94) axis(95) axis(96)];
            f = [259 262 265 268 271 274 277 280 283 286];
            d0 = i;
            f0 = lagrange_interp(f, d, d0);
            estimated(i) = f0;
        end
    end
    end
    parameters(:,q) = estimated';
    if z == 1
        X_Coordinates(:,q) = parameters(:,q);
    elseif z == 2
        Y_Coordinates(:,q) = parameters(:,q);
    elseif z == 3
        Z_Coordinates(:,q) = parameters(:,q);
    end
    end
end
end