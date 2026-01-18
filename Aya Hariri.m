clc;
clear;

% 1) «·≈⁄œ«œ«  «·√”«”Ì…
START = 8*60;
FINISH = 12*60;
TOTAL_TIME = FINISH - START;

INT_A = 20;
INT_B = 45;

PA = 0.6; 
PB = 0.4;

N = 10000;

% 2) √Êﬁ«   ‘€Ì· «·»—«„Ã
slotsA = 0:INT_A:(TOTAL_TIME - INT_A);
slotsB = 0:INT_B:(TOTAL_TIME - INT_B);

% 3) „’›Ê›«  «·«‰ Ÿ«—
wA = [];
wB = [];
startedA = 0;
startedB = 0;

% 4) «·„Õ«ﬂ«…
for k = 1:N
    t_arrive = rand() * TOTAL_TIME;

    choice = rand() <= PA;  % 1 = A ° 0 = B

    if choice
        % »—‰«„Ã A
        next_cand = slotsA(slotsA >= t_arrive);
        if isempty(next_cand), continue; end

        next_start = next_cand(1);
        wA(end+1) = next_start - t_arrive;

        if any(slotsA < t_arrive)
            startedA = startedA + 1;
        end

    else
        % »—‰«„Ã B
        next_cand = slotsB(slotsB >= t_arrive);
        if isempty(next_cand), continue; end

        next_start = next_cand(1);
        wB(end+1) = next_start - t_arrive;

        if any(slotsB < t_arrive)
            startedB = startedB + 1;
        end
    end
end

% 5) «·≈Õ’«∆Ì« 
nA = length(wA);
nB = length(wB);

avgA = mean(wA);
avgB = mean(wB);

pA = startedA / nA;
pB = startedB / nB;

gt15_A = sum(wA > 15) / nA;
gt15_B = sum(wB > 15) / nB;

% 6) «·—”„ (√”·Ê» ÃœÌœ ñ ﬂ· —”„ ›Ì Figure „” ﬁ·)
figure;
histogram(wA, 'Normalization', 'pdf', 'FaceAlpha', 0.7);
title(' Ê“Ì⁄ «·«‰ Ÿ«— ··»—‰«„Ã A');
xlabel('«·«‰ Ÿ«— (œﬁÌﬁ…)');
ylabel('PDF');
grid on;

figure;
histogram(wB, 'Normalization', 'pdf', 'FaceAlpha', 0.7);
title(' Ê“Ì⁄ «·«‰ Ÿ«— ··»—‰«„Ã B');
xlabel('«·«‰ Ÿ«— (œﬁÌﬁ…)');
ylabel('PDF');
grid on;

disp('«·—”„  „ ≈‰Ã«“Â.');