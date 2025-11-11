SET SERVEROUTPUT ON;

DECLARE
  TYPE salary_history_t IS VARRAY(3) OF NUMBER;

  TYPE emp_with_history_t IS RECORD (
    emp_id NUMBER,
    name VARCHAR(100),
    salaries salary_history_t
  );

  emp_record emp_with_history_t;
BEGIN
  emp_record.emp_id := 999;
  emp_record.name := 'Historic Employee';
  emp_record.salaries := salary_history_t(4000, 4200, 4400);

  DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_record.name);
  FOR i IN 1..emp_record.salaries.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Month ' || i || ': ' || emp_record.salaries(i));
  END LOOP;
END;
/
