SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.4 - PARAMETERISED CURSOR - COURSE AND SEMESTER
--
-- Question:
-- Write a cursor that accepts a course and a semester and
-- displays all matching members with their join date
-- formatted as DD-MON-YYYY.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts two parameters.
-- 2. Course and semester are used in the WHERE condition.
-- 3. TO_CHAR() formats the join date as DD-MON-YYYY.
-- 4. Cursor parameters should not have a size.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    -- ========================================================

    CURSOR c_member (
        p_course VARCHAR2,
        p_semester NUMBER
    ) IS
        SELECT member_id,
               member_name,
               course,
               semester,
               join_date
        FROM lib_member
        WHERE UPPER(course) = UPPER(p_course)
          AND semester = p_semester
        ORDER BY member_id;


BEGIN

    -- ========================================================
    -- Test:
    -- Course   = MSc IT
    -- Semester = 3
    --
    -- This matches the sample data for Arjun Mehta and
    -- Vivek Nair.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Course : MSc IT | Semester : 3'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_member IN c_member('MSc IT', 3)
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Member ID : ' || r_member.member_id
            || ' | Name : ' || r_member.member_name
            || ' | Join Date : '
            || TO_CHAR(
                r_member.join_date,
                'DD-MON-YYYY'
            )
        );

    END LOOP;


END;
/