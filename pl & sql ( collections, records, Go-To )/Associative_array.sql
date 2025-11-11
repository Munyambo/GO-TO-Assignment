SET SERVEROUTPUT ON;

DECLARE
  
  TYPE emp_name_tab IS TABLE OF VARCHAR(50) INDEX BY PLS_INTEGER;
  emp_names emp_name_tab;

  
  TYPE city_pop_tab IS TABLE OF NUMBER INDEX BY VARCHAR(50);
  city_pop city_pop_tab;

  idx PLS_INTEGER;
BEGIN

  emp_names(100) := 'Alvin Munyambo';
  emp_names(101) := 'Jimmy Rwema';
  emp_names(102) := 'Kelly Kabucye';

  DBMS_OUTPUT.PUT_LINE('Employee name for ID 101: ' || emp_names(101));
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'All employee names:');
  idx := emp_names.FIRST;
  WHILE idx IS NOT NULL LOOP
    DBMS_OUTPUT.PUT_LINE('ID ' || idx || ' -> ' || emp_names(idx));
    idx := emp_names.NEXT(idx);
  END LOOP;


  city_pop('Kigali') := 1300000;
  city_pop('Musanze') := 800000;
  city_pop('Huye') := 650000;

  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'City populations:');
  DBMS_OUTPUT.PUT_LINE('Kigali: ' || city_pop('Kigali'));
  DBMS_OUTPUT.PUT_LINE('Musanze: ' || city_pop('Musanze'));
END;
/
