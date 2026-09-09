SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.5 - MEMBER NAME UPPERCASE FORMAT
--
-- Question:
-- Display every member's name in the format:
--
-- 1. RIYA SHAH (MSc IT - Sem 1)
--
-- Convert the member name to upper case inside the loop.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. Use an explicit/simple cursor.
-- 2. Use a cursor FOR LOOP to process members.
-- 3. UPPER() converts the member name to uppercase.
-- 4. Display course and semester along with the member name.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    -- ========================================================

    CURSOR c_member IS
        SELECT member_name, course, semester
        FROM lib_member
        ORDER BY member_id;


BEGIN

    -- ========================================================
    -- Process each library member.
    -- Oracle automatically opens, fetches and closes the
    -- cursor when using a cursor FOR LOOP.
    -- ========================================================

    FOR r_member IN c_member
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            c_member%ROWCOUNT
            || '. '
            || UPPER(r_member.member_name)
            || ' ('
            || r_member.course
            || ' - Sem '
            || r_member.semester
            || ')'
        );

    END LOOP;


END;
/