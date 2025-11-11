-- Varray example --

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

-- End of varray example --

--Nested array example --

SET SERVEROUTPUT ON;

DECLARE
 
  TYPE salary_table IS TABLE OF NUMBER;
  salaries salary_table := salary_table(50000, 60000, 70000);
  total_sum NUMBER := 0;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Initial nested table content:');
  FOR i IN 1..salaries.LAST LOOP
    IF salaries.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE('Index ' || i || ' -> ' || salaries(i));
      total_sum := total_sum + salaries(i);
    END IF;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total salary sum = ' || total_sum);

  -- Delete one element
  salaries.DELETE(2);
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'After DELETE(2):');
  FOR i IN 1..salaries.LAST LOOP
    IF salaries.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE('Index ' || i || ' -> ' || salaries(i));
    ELSE
      DBMS_OUTPUT.PUT_LINE('Index ' || i || ' -> <deleted>');
    END IF;
  END LOOP;

  -- Extend the table (add more elements)
  salaries.EXTEND(2);
  salaries(salaries.LAST - 1) := 22000;
  salaries(salaries.LAST) := 25000;

  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'After EXTEND:');
  FOR i IN 1..salaries.LAST LOOP
    IF salaries.EXISTS(i) THEN
      DBMS_OUTPUT.PUT_LINE('Index ' || i || ' -> ' || salaries(i));
    END IF;
  END LOOP;
END;
/

-- End nested array --

-- Record example --

SET SERVEROUTPUT ON;

DECLARE
  
  emp_row employees%ROWTYPE;


  TYPE employee_rec IS RECORD (
    emp_id NUMBER,
    full_name VARCHAR(50),
    salary NUMBER
  );
  emp_custom employee_rec;


  CURSOR c_emp IS SELECT employee_id, first_name, last_name, salary FROM employees WHERE department_id = 10;
  emp_cur c_emp%ROWTYPE;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Table-based Record Example ---');
  SELECT * INTO emp_row FROM employees WHERE employee_id = 100;
  DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_row.first_name || ' ' || emp_row.last_name || ', Salary: ' || emp_row.salary);

  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- User-defined Record Example ---');
  emp_custom.emp_id := 500;
  emp_custom.full_name := 'New Employee';
  emp_custom.salary := 75000;
  DBMS_OUTPUT.PUT_LINE('Emp ID: ' || emp_custom.emp_id || ', Name: ' || emp_custom.full_name || ', Salary: ' || emp_custom.salary);

  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Cursor-based Record Example ---');
  OPEN c_emp;
  LOOP
    FETCH c_emp INTO emp_cur;
    EXIT WHEN c_emp%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || emp_cur.employee_id || ' -> ' || emp_cur.first_name || ' ' || emp_cur.last_name || ', Salary: ' || emp_cur.salary);
  END LOOP;
  CLOSE c_emp;
END;
/

-- End record example --

-- Record & Varray example --

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

-- end of record & varray example --

-- Associative array --

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

-- End of asociative example --

-- GOTO example --

SET SERVEROUTPUT ON;

DECLARE
  v_emp_id NUMBER := 101;
  v_emp employees%ROWTYPE;
  v_min_salary CONSTANT NUMBER := 1000;
  v_max_salary CONSTANT NUMBER := 100000;
BEGIN
  IF v_emp_id IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Employee ID is NULL.');
    GOTO cleanup;
  END IF;

  BEGIN
    SELECT * INTO v_emp FROM employees WHERE employee_id = v_emp_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Employee not found.');
      GOTO cleanup;
  END;

  IF v_emp.salary < v_min_salary OR v_emp.salary > v_max_salary THEN
    GOTO invalid_salary;
  END IF;

  DBMS_OUTPUT.PUT_LINE('Employee OK: ' || v_emp.first_name || ' ' || v_emp.last_name || ', Salary: ' || v_emp.salary);
  GOTO cleanup;

  <<invalid_salary>>
  DBMS_OUTPUT.PUT_LINE('Invalid salary for employee ' || v_emp_id || ': ' || v_emp.salary);

  <<cleanup>>
  DBMS_OUTPUT.PUT_LINE('Process finished.');
END;
/

-- End of go-to example --

