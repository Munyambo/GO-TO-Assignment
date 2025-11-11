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
