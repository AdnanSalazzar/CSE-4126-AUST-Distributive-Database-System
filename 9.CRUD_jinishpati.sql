set serveroutput on;
set verify off;

CREATE OR REPLACE PACKAGE crud_pkg AS 
    procedure insert_stad(stad_name stadium1.stadium_name%TYPE,stad_city stadium1.city%TYPE,stad_capacity stadium1.capacity%TYPE);
    procedure update_stad(stad_name stadium1.stadium_name%TYPE,stad_capacity stadium1.capacity%TYPE);
    procedure delete_stad(stad_name stadium1.stadium_name%TYPE,stad_city stadium1.city%TYPE,stad_capacity stadium1.capacity%TYPE);
    procedure insert_coach(coach_nat coach1.nationality%TYPE, coach_name coach1.coach_name%TYPE);
    procedure delete_coach(coach_nat coach1.nationality%TYPE, coach_name coach1.coach_name%TYPE);
END crud_pkg;
/
CREATE OR REPLACE PACKAGE BODY crud_pkg AS 
    procedure insert_stad(stad_name stadium1.stadium_name%TYPE,stad_city stadium1.city%TYPE,stad_capacity stadium1.capacity%TYPE)
    is
    BEGIN
        INSERT INTO stadium1 (stadium_name, city, capacity) values (stad_name,stad_city,stad_capacity);
    END insert_stad;

    procedure update_stad(stad_name stadium1.stadium_name%TYPE,stad_capacity stadium1.capacity%TYPE)
    is
    BEGIN
        UPDATE stadium1 SET stadium1.capacity = stad_capacity WHERE stadium_name = stad_name ;
    END update_stad;

    procedure delete_stad(stad_name stadium1.stadium_name%TYPE,stad_city stadium1.city%TYPE,stad_capacity stadium1.capacity%TYPE)
    is
    BEGIN
        DELETE FROM stadium1 WHERE stadium_name = stad_name AND city = stad_city AND capacity = stad_capacity;
    END delete_stad;
    -------------------------stad procedure done------------------------------
    procedure insert_coach(coach_nat coach1.nationality%TYPE, coach_name coach1.coach_name%TYPE)
    is
        coach_id1 coach1.coach_id%TYPE;
    begin
        SELECT MAX(coach_id) INTO coach_id1 FROM coach1;
        coach_id1 := coach_id1 + 1;
        INSERT INTO coach1 (coach_id, nationality, coach_name) VALUES (coach_id1, coach_nat, coach_name);
    end insert_coach;
    procedure delete_coach(coach_nat coach1.nationality%TYPE, coach_name coach1.coach_name%TYPE)
    is
    BEGIN
        DELETE FROM coach1 WHERE coach_name = coach_name AND coach_id = (SELECT MAX(coach_id) FROM coach1);
    END delete_coach;
    
END crud_pkg;
/

-- PL/SQL block
DECLARE
    stad_name stadium1.stadium_name%TYPE; 
    stad_city stadium1.city%TYPE; 
    stad_capacity stadium1.capacity%TYPE;
    nameofstad stadium1%ROWTYPE;
    choice NUMBER;
BEGIN
    choice := &choiceforstad;
    stad_name := '&stadium_name';
    stad_city := '&stadium_city';
    stad_capacity := &stadium_capacity;

    IF choice = 1 THEN
        IF stad_capacity >= 50000 THEN
            crud_pkg.insert_stad(stad_name, stad_city, stad_capacity);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Invalid stadium capacity');     
        END IF;    
        -- Call the insert procedure here
    ELSIF choice = 2 THEN
        IF stad_capacity >= 50000 THEN
            BEGIN
                SELECT * INTO nameofstad FROM stadium1 WHERE stadium_name = stad_name;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('Invalid stadium name for update operation');
                    RETURN; -- Exit the block since no data was found
            END;

            crud_pkg.update_stad(stad_name, stad_capacity);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Invalid stadium capacity'); 
        END IF;     
        -- Call the update procedure here 
    ELSIF choice = 3 THEN     
         IF stad_capacity >= 50000 THEN
            BEGIN
                SELECT * INTO nameofstad FROM stadium1 WHERE stadium_name = stad_name;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('Invalid stadium name for delete operation');
                    RETURN; -- Exit the block since no data was found
            END;

            crud_pkg.delete_stad(stad_name, stad_city, stad_capacity);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Invalid stadium capacity'); 
        END IF;     
        -- Call the update procedure here 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice');     
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

DECLARE
    coach_nat coach1.nationality%TYPE; 
    coach_name coach1.coach_name%TYPE; 
    nameofcoach coach1%ROWTYPE;
    choice NUMBER;
BEGIN
    choice := &choiceforcoach;
    coach_name := '&coach_name';
    coach_nat := '&coach_nationality';

    IF choice = 1 THEN
        IF coach_nat = 'Spanish' THEN
            crud_pkg.insert_coach(coach_nat, coach_name);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Invalid coach nationality');     
        END IF;    
        -- Call the insert procedure here
    ELSIF choice = 2 THEN
        IF coach_nat = 'Spanish' THEN
            crud_pkg.delete_coach(coach_nat, coach_name);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Invalid coach nationality'); 
        END IF;     
        -- Call the update procedure here 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid choice for coach');     
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

 select * from coach1 ; 
 select * from stadium1 ; 
 