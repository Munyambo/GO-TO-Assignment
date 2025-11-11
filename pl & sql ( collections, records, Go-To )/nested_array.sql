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
