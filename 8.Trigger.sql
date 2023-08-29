set serveroutput on ; 
set verify off;

CREATE OR REPLACE TRIGGER stad1_insert
before INSERT ON stadium1
FOR EACH ROW 
DECLARE
     exp_caperror EXCEPTION;
BEGIN
    IF :NEW.capacity < 50000 THEN
        Raise exp_caperror;
    ELSE
        DBMS_OUTPUT.PUT_LINE('INSERTED IN THE STADIUM TABLE AT SITE 1.');    
    END IF;
    EXCEPTION
        WHEN exp_caperror THEN
		DBMS_OUTPUT.PUT_LINE('Stadium input capacity must be over or equal to 50000');
    
END;
/

CREATE OR REPLACE TRIGGER stad1_delete
before DELETE ON stadium1
FOR EACH ROW 
DECLARE
     exp_caperror1 EXCEPTION;
BEGIN
    IF :NEW.capacity < 50000 THEN
        Raise exp_caperror1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('DELETED IN THE STADIUM TABLE AT SITE 1.');    
    END IF;
    EXCEPTION
        WHEN exp_caperror1 THEN
		DBMS_OUTPUT.PUT_LINE('Stadium input capacity must be over or equal to 50000');
    
END;
/


CREATE OR REPLACE TRIGGER stad1_update
BEFORE UPDATE ON stadium1
FOR EACH ROW 
DECLARE
    nameofstad stadium1%ROWTYPE;
    exp_upcaperror EXCEPTION;
BEGIN
    SELECT * INTO nameofstad FROM stadium1 WHERE stadium_name = :NEW.stadium_name;
    
    IF :NEW.capacity < 50000 THEN
        RAISE exp_upcaperror;
    ELSE
        DBMS_OUTPUT.PUT_LINE('UPDATED IN THE STADIUM TABLE AT SITE 1.');    
    END IF;
    
EXCEPTION
    WHEN exp_upcaperror THEN
        DBMS_OUTPUT.PUT_LINE('Stadium input capacity must be over or equal to 50000');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid stadium name input');
END;
/
