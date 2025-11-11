SET SERVEROUTPUT ON;

DECLARE
  TYPE salary_varray IS VARRAY(3) OF NUMBER;
  v_salaries salary_varray := salary_varray(50000, 60000, 70000);
  total NUMBER := 0;
BEGIN
  FOR i IN 1..v_salaries.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Salary ' || i || ' = ' || v_salaries(i));
    total := total + v_salaries(i);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total salary = ' || total);
END;
/
