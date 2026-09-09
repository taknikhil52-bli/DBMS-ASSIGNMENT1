SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.12 - PARAMETERISED CURSOR - NAME INITIAL
--
-- Question:
-- Write a parameterised cursor that accepts a name initial
-- such as 'A' and lists all members whose name starts with
-- that letter.
--
-- Accept the letter from the user and handle both upper
-- and lower case input.
--
-- Test with initial 'A'.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts the starting letter as a parameter.
-- 2. SUBSTR() extracts the first character of the name.
-- 3. UPPER() makes the comparison case-insensitive.
-- 4. &initial accepts the letter from the user.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- p_initial = first letter entered by the user.
    -- ========================================================

    CURSOR c_member (
        p_initial VARCHAR2
    ) IS
        SELECT member_id,
               member_name,
               course,
               semester
        FROM lib_member
        WHERE UPPER(SUBSTR(member_name, 1, 1))
              = UPPER(p_initial)
        ORDER BY member_id;


BEGIN

    -- ========================================================
    -- Display the entered initial.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Members whose name starts with : ' || '&initial'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Open the parameterised cursor.
    --
    -- The user supplied initial is passed to the cursor.
    -- ========================================================

    FOR r_member IN c_member('&initial')
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Member ID : ' || r_member.member_id
            || ' | Name : ' || r_member.member_name
            || ' | Course : ' || r_member.course
            || ' | Semester : ' || r_member.semester
        );

    END LOOP;


END;
/