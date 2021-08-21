function [centroids] = clustering_pc(points, NC)
    [nrpncte dimensiune] = size(points);
    %matrice in care salvez indicii punctelor ce apartin fiecarui cluster
    A = zeros(NC, nrpncte);
    %prima pozitie o folosesc pentru a numara punctele din fiecare cluster
    A(1:NC, 1) = 1;
    %salvarea indicilor din matricea points a punctelor,
    %in functie de restul impartirii la NC
    for i = 1:nrpncte
        nr_cluster = mod(i, NC);

        if nr_cluster == 0;
            nr_cluster = NC;
        endif

        A(nr_cluster, A(nr_cluster, 1) + 1) = i;
        A(nr_cluster, 1)++;
    endfor

    centroids = zeros(NC, dimensiune);
    ccentroids = zeros(NC, dimensiune);
    %calcularea centroizilor
    for i = 1:NC

        for j = 1:dimensiune
            suma = 0;

            for k = 2:A(i, 1)
                suma = suma + points(A(i, k), j);
            endfor

            centroids(i, j) = suma / (A(i, 1) - 1);
        endfor

    endfor
%repetam pana cand centroizii noi sunt la fel ca 
%cei calculati la pasul anterior
    while ~isequal(centroids, ccentroids)
        A = zeros(NC, nrpncte);
        A(1:NC, 1) = 1;
        ccentroids = centroids;
 %realocarea punctelor in clustere, 
 %in functie de distanta minima intre punct si fiecare centroid
        for i = 1:nrpncte
            min = inf;

            for j = 1:NC
                distanta = 0;

                for k = 1:dimensiune
                    distanta = distanta + (centroids(j, k) - points(i, k))^2;
                endfor

                if distanta <= min
                    min = distanta;
                    pmin = j;
                endif

            endfor

            A(pmin, A(pmin, 1) + 1) = i;
            A(pmin, 1)++;
        endfor
%recalcularea centroizilor
        for i = 1:NC

            for j = 1:dimensiune
                suma = 0;

                for k = 2:A(i, 1)
                    suma = suma + points(A(i, k), j);
                endfor

                centroids(i, j) = suma / (A(i, 1) - 1);
            endfor

        endfor

    endwhile

endfunction
