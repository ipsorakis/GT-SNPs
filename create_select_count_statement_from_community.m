function SELECT_STATEMENT = create_select_count_statement_from_community(community,BIRDS_DATABASE)

N = length(community);

SELECT_STATEMENT = ' select count(ringNo) as count from Individuals where (';

for i=1:N
    current_bird = BIRDS_DATABASE.get_bird_by_index(community(i));
    
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,' ringNo = ''',current_bird.ringNo,''' ');
    
    if i~=N
       SELECT_STATEMENT = strcat(SELECT_STATEMENT,' or '); 
    end
end

SELECT_STATEMENT = strcat(SELECT_STATEMENT,')');

end