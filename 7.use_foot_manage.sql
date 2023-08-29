
DECLARE
stad_name varchar2(30);
c_nat varchar2(30);
team_name varchar2(30);
pl_date DATE;
playerName VARCHAR2(30);
totGoal integer;

begin	

	c_nat:= 'Spanish';
	foot_manage.coach_pro(c_nat);

	
	foot_manage.player_pro('Forward','Barcelona');


    team_name:= 'Barcelona';
	stad_name:= foot_manage.stad_func(team_name);
	dbms_output.put_line('.......................................');
	dbms_output.put_line('Stadium name of Barcelona :'|| (stad_name));
	dbms_output.put_line('.......................................');


    
	team_name:= 'Real Madrid';
	foot_manage.findTeamstat(team_name);
	

    
	playername:= foot_manage.topGoalScorer();
	dbms_output.put_line('.......................................');
	dbms_output.put_line('Top goal scorer: '|| (playername));
	dbms_output.put_line('.......................................');


    
	playerName := 'Lionel Messi';
	totGoal:=foot_manage.totalGoals(playerName);
	DBMS_OUTPUT.PUT_LINE('.......................................................');
	DBMS_OUTPUT.PUT_LINE('Total Goals scored by '|| (playerName) || ' : '|| (totGoal));
	DBMS_OUTPUT.PUT_LINE('.......................................................');
	

    
	
	
	pl_date := TO_DATE('2017-Aug-17', 'YYYY-MON-DD');
    foot_manage.up_pro(pl_date); 

	

end;
/




