I = imread('lena.jpg');
H = Haar_2D(I);

f_min = min(H(:));
f_max = max(H(:));

xx = f_min:f_max;
hh= histc(H(:)',xx);

figure;plot(xx,hh);

[p,c] = lloyds(H(:)',7);

hold on
    for ii=1:size(c,2)
        plot([c(ii);c(ii)],[0;max(hh)*1.1],'r');
    end
    hold off
    
    hold on
    for ii=1:size(p,2)
        plot([p(ii);p(ii)],[0;max(hh)*1.1],'k');
    end
    hold off