set serveroutput on ; 
--COACH NONESENSES

declare
c_id number;
c_nat varchar2(20);
c_name varchar2(20);

begin
    
    FOR I IN (SELECT * FROM coach ) LOOP
        c_id    := I.coach_id;
        c_nat   := I.nationality;
        c_name  := I.coach_name;

        IF c_nat = 'Spanish'THEN 
        insert into coach1 values(c_id,c_nat,c_name);
		
		ELSE 
		insert into coach2 values(c_id,c_nat,c_name);
		
		END IF;
    end LOOP;
END;
/


---STADIUM NONESENSES

DECLARE
s_name varchar2(20);
s_city varchar2(20);
cap number;

BEGIN
    FOR I IN (SELECT * FROM stadium) LOOP
        s_name  := I.stadium_name;
        s_city  := I.city;
        cap     := I.capacity;


        IF cap >= 50000
		THEN insert into stadium1 values(s_name,s_city,cap);

		ELSE
		insert into stadium2 values(s_name,s_city,cap);
		
		END IF;

    END LOOP;

END;
/

commit;
 


--REFREE NONESENSE 

DECLARE
    
r_id number;
r_name varchar2(20);
r_nat varchar2(20);


BEGIN
    FOR I IN (SELECT * FROM referee) LOOP
        r_id    := I.ref_id;
        r_name  := I.ref_name;
        r_nat   := i.nationality;

    IF r_nat = 'Spanish' THEN
		insert into referee1 values(r_id,r_name,r_nat);
		
		ELSE
		insert into referee2 values(r_id,r_name,r_nat);

    END IF;

    END LOOP;
END;
/



----TEAM 1 
DECLARE
t_id number;
t_name varchar2(20);
tc_id number;
t_stadium varchar2(20);
s_city varchar2(20); ---- rememver to kick this out declared before


BEGIN

    FOR I IN (SELECT * FROM TEAM INNER JOIN stadium1 ON stadium1.stadium_name = TEAM.stadium_name) LOOP 
        t_id        :=I.team_id;
        t_name      :=I.team_name;
        tc_id       :=I.coach_id;
        s_city      :=I.city;

        insert into team1 values(t_id,t_name,tc_id,s_city);
    END LOOP ;
END;
/

---TEAM2


declare

t_id number;
s_cap number;
t_stadium varchar2(20);--remmeber to kicj thuis oity 

BEGIN

    FOR I IN (SELECT * FROM TEAM natural JOIN stadium1 ) LOOP 
        t_id        :=I.team_id;
        t_stadium   :=I.STADIUM_NAME;
        s_cap       :=I.capacity;
        

        insert into team2 values(t_id,t_stadium,s_cap);
    END LOOP ;
END;
/


 



---PLAYER 1 AND 2

DECLARE

p_id number;
p_name varchar2(20);
p_nat varchar2(20);
p_weight number;
p_height number;
p_date date;
p_pos varchar2(20);
p_team number;


BEGIN

    FOR I IN (select player_id, player_name, nationality, weight, height, date_of_birth, player_position, team_id from player ) LOOP

    p_id        := I.player_id     ;
    p_name      := I.player_name    ;  
    p_nat       := I.nationality     ; 
    p_weight    := I.weight    ;
    p_height    := I.height    ;
    p_date      := I.date_of_birth;
    p_pos       := I.player_position;     
    p_team      := I.team_id   ;


    IF p_team = 4 THEN
			insert into player1 values(p_id,p_name,p_nat,p_weight,p_height,p_date,p_pos,p_team);
		ELSE 
			insert into player2 values(p_id,p_name,p_nat,p_weight,p_height,p_date,p_pos,p_team);	
		END IF;
    END LOOP; 
END;
/





 
SELECT * FROM coach1; 
SELECT * FROM coach2; 

SELECT * FROM stadium1; 
SELECT * FROM stadium2; 

SELECT * FROM referee1; 
SELECT * FROM referee2; 

SELECT * FROM team1; 
SELECT * FROM team2;  

SELECT * FROM PLAYER1;
SELECT * FROM PLAYER2;
