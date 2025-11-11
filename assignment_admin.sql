create table employees (
     employee_id NUMBER PRIMARY KEY,
     first_name VARCHAR(50),
     last_name VARCHAR(50),
     department_id NUMBER,
     salary NUMBER,
     city VARCHAR(50)
);



INSERT INTO employees VALUES (100, 'Alvin', 'Munyambo', 10, 50000, 'Kigali');
INSERT INTO employees VALUES (101, 'Jimmy', 'Rwema', 20, 60000, 'Musanze');
INSERT INTO employees VALUES (102, 'Kelly', 'Kabucye', 30, 70000, 'Huye');

COMMIT;

