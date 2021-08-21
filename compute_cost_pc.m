function [cost] = compute_cost_pc(points, centroids)
    [nr_puncte dimensiune] = size(points);
    [NC dimensiune] = size(centroids);
    cost = 0;

    for i = 1:nr_puncte
        min = inf;

        for j = 1:NC
            distanta = 0;

            for k = 1:dimensiune
                distanta = distanta + (centroids(j, k) - points(i, k))^2;
            endfor

            distanta = sqrt(distanta);

            if distanta <= min
                min = distanta;
                pmin = j;
            endif

        endfor

        cost = cost + min;
    endfor

endfunction
