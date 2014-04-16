function isOK = check_GENOTYPE_DATA_consistency(DATA)

N = max(DATA(:,1))
max_snp_index = max(DATA(:,2))

OKs = 0;
active = 0;
for n=1:N
    DATA_n = DATA(DATA(:,1)==n,:);
    if isempty(DATA_n)
        continue;
    end
    active = active+1;
    diffs = diff(DATA_n(:,2));
    sum_diffs = sum(diffs);
    if sum_diffs==max_snp_index-1
        OKs = OKs + 1;
    else
        n
    end
end

isOK = OKs==active;

end