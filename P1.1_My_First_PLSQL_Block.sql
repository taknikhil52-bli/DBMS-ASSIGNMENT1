SET SERVEROUTPUT ON;

-- ============================================================
-- P1.1 - My First PL/SQL Block
--
-- Question:
-- (a) Print your name and roll number.
-- (b) Declare v_message VARCHAR2(100), assign
--     "Welcome to PL/SQL!" and print it.
-- (c) Calculate roll_no MOD 7 + 1 as the lucky number
--     and print it.
--
-- Key points to solve this question:
-- 1. SET SERVEROUTPUT ON is required to display DBMS_OUTPUT.
-- 2. Use DECLARE for variable declaration.
-- 3. Use BEGIN ... END; for executable statements.
-- 4. Use DBMS_OUTPUT.PUT_LINE() to display output.
-- 5. Lucky number = roll number MOD 7 + 1.
-- ============================================================

DECLARE
    v_message VARCHAR2(100) := 'Welcome to PL/SQL!';
    v_lucky_number NUMBER;
BEGIN
    -- (a) Print student's name and roll number
    DBMS_OUTPUT.PUT_LINE('Name     : Nikhil tak');
    DBMS_OUTPUT.PUT_LINE('Roll No  : 50');

    -- (b) Print the message stored in the variable
    DBMS_OUTPUT.PUT_LINE('Message  : ' || v_message);

    -- (c) Calculate lucky number using the given formula
    -- 50 MOD 7 = 5
    -- 5 + 1 = 6
    v_lucky_number := MOD(50, 7) + 1;

    DBMS_OUTPUT.PUT_LINE('Lucky No : ' || v_lucky_number);
END;
/