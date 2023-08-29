
CREATE OR REPLACE PACKAGE BODY foot_manage AS 

    PROCEDURE coach_pro(c_nation IN VARCHAR) IS
        c_name VARCHAR(30);
        team_n VARCHAR(30);
    BEGIN
        dbms_output.put_line(' ');
        dbms_output.put_line('................................................');
        dbms_output.put_line('Coach Name            Team Name');
        dbms_output.put_line('................................................');

        FOR I IN (SELECT c.coach_name, t.team_name
                    FROM coach1 c
                    INNER JOIN team1 t ON t.coach_id = c.coach_id
                    WHERE c.nationality = c_nation) LOOP

            c_name := I.coach_name; 
            team_n := I.team_name;

            dbms_output.put_line((c_name) || '            ' || (team_n));

            
        END LOOP;

    

    END coach_pro;

    PROCEDURE player_pro(pla_pos in varchar, t_name2 in varchar) IS
        pla_name varchar(30);
    BEGIN
        dbms_output.put_line(' ');
        dbms_output.put_line('.......................................');
        dbms_output.put_line('Forward Players of '||(t_name2)|| ': ');
        dbms_output.put_line('.......................................');
    
        FOR I IN (  SELECT player1.player_name 
                    FROM player1 
                    INNER JOIN team1 ON team1.team_id = player1.team_id 
                    WHERE player1.player_position = pla_pos AND team1.team_name = t_name2) LOOP
    
            pla_name := I.player_name;
            dbms_output.put_line(pla_name);
        END LOOP;
    END player_pro;


  
function stad_func(t_name in varchar)
return varchar2
is
sta_name varchar2(30);

begin
    SELECT team2.stadium_name INTO sta_name 
    FROM team2 
    INNER JOIN team1 ON team1.team_id = team2.team_id 
    WHERE team1.team_name = t_name;

  return sta_name;

end stad_func;



procedure findTeamstat (tname in varchar2)
is

seasons varchar(10);
pos varchar(30);

begin

	dbms_output.put_line(' ');
	DBMS_OUTPUT.PUT_LINE('................................');
	DBMS_OUTPUT.PUT_LINE('	Season	' || '	Position	');
	DBMS_OUTPUT.PUT_LINE('................................');

    FOR I IN (  SELECT team_stats.season, team_stats.position 
                FROM team_stats 
                WHERE team_id = ( SELECT team1.team_id
                                  FROM team1 
                                  WHERE team1.team_name = tname)) LOOP
            
            seasons := I.season;
            pos :=I.position;

        DBMS_OUTPUT.PUT_LINE('	'||(seasons) || '		'|| (pos));

    END LOOP ;

end findTeamstat;



function topGoalScorer
	return varchar
	is
	
    pname varchar(30);

    begin
	
	SELECT player.player_name into pname
     FROM player
      where player.player_id=( select player_stats.player_id
                                 from player_stats 
                                where player_stats.goals=( select max(player_stats.goals)
                                                             from player_stats ));

    return pname;
end topGoalScorer;


function totalGoals(pname in varchar2)
    return integer
	is
	
    tot_gl integer;

begin
	
	SELECT SUM(player_stats.goals) into tot_gl FROM player_stats GROUP BY player_stats.player_id HAVING player_stats.player_id = (SELECT player1.player_id FROM player1 WHERE player1.player_name= pname);
	
return tot_gl;
end totalGoals;   



procedure up_pro(p_date in date) is
    h_team varchar(30);
    a_team varchar(30);
    pl_date date;
    st_time varchar(30);
begin
    dbms_output.put_line(' ');
    dbms_output.put_line('.................................................');
    dbms_output.put_line('        Upcoming Match Schedules: ');
    dbms_output.put_line('Home Team     Away Team     Date      Start Time');
    dbms_output.put_line('.................................................');

    FOR I IN (
        SELECT homeTeam.team_name AS home_team_name, awayTeam.team_name AS away_team_name, 
               schedules.play_date, time_slot.start_time 
        FROM time_slot 
        INNER JOIN schedules ON time_slot.time_slot_id = schedules.time_slot_id 
        INNER JOIN matchplay ON schedules.match_id = matchplay.match_id
        INNER JOIN team homeTeam ON matchplay.home_team_id = homeTeam.team_id 
        INNER JOIN team awayTeam ON matchplay.away_team_id = awayTeam.team_id 
        WHERE schedules.play_date > p_date
    ) LOOP
        h_team := I.home_team_name;               
        a_team := I.away_team_name;
        pl_date := I.play_date;
        st_time := I.start_time;

        dbms_output.put_line(h_team || '      ' || a_team || '    ' || pl_date || '    ' || st_time);
    END LOOP;
end up_pro;


END foot_manage;
/


