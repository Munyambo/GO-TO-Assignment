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
