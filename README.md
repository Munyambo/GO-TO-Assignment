# plsql_Collections, Records and GO-TO Assignment

# 27146 Alvin Munyambo

# This repository contains Oracle PL/SQL scripts that demonstrate:

# Collections : is basically a data structure in PL/SQL that lets you store multiple values under one name (like an array or list). There are three main types:

1. Varray( Variable-array )  : Fixed maximum size (you define the limit), always densely filled(no gaps).
   
2. Nested Table :  Unbounded size( you don't specify a max), you can delete elements and create gaps, when the size can change that would be great nut if it can't, you have to delete and extend items.
   
3. Associative Array( index-by table): You choose the key type e.g: integer or varchar, very efficient for lookups by key (e.g employee-ID -> f-name) and it has no size built-in limit.


  # Why use collections?

- Handle lists of data in memory instead of one by one.
- To perform operations like looping through multiple salaries, deleting bad data, extending arrays, mapping keys to values.
- Helps your PL/SQL logic be more efficient and expressive.


# Records : A record lets you group different types of data together under one name. It's similar to a 'struct' in other programming languages.

  - You can use %ROWTYPE to create a record that matches the structure of a table row. For example employees%ROWTYPE gives you a record with all the columns of the employees table.
  - You can define your own record type (using TYPE record_name IS RECORD (...)) with custom fields.
  - You can cursor-based records (e.g, cursor_name%ROWTYPE) to fetch rows and put them into a record variable.
 
    # Why use records?

    - To make code cleaner
   

# GOTO Statement: The GOTO statement in PL/SQL lets you jump to a labelled point in your code.

   ## For example:
   
  IF some_condition THEN
  GOTO error_label;
  END IF;

  <<error_label>>
  DBMS_OUTPUT.PUT_LINE('Error happened');


  # Why use GOTO?

 - To handle " early exit " logic or jump to cleanup/error handling sections.
 - It's a tool, but in modern code many developers prefer structured flows( exceptions, loops, procedures) instead of GOTO.

 - A quic thing to be careful about, when using GO-TO or over using it too much can make your code hard to read/maintain.



# ---- END ----   

    

