function SELECT_STATEMENT = create_select_statement_from_community(community,BIRDS_DATABASE,parenthesis_flag)

if nargin<3
    parenthesis_flag = true;
end


N = length(community);

if parenthesis_flag
    SELECT_STATEMENT = ' (select ringNo from Individuals where (';
else
    SELECT_STATEMENT = ' select ringNo from Individuals where (';
end

for i=1:N
    current_bird = BIRDS_DATABASE.get_bird_by_index(community(i));
    
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,' ringNo = ''',current_bird.ringNo,''' ');
    
    if i~=N
        SELECT_STATEMENT = strcat(SELECT_STATEMENT,' or ');
    end
end

if parenthesis_flag
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,'))');
else
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,')');
end

end