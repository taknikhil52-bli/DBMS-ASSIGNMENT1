SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.6 - PARAMETERISED CURSOR - MEMBER ISSUED BOOKS
--
-- Question:
-- Write a parameterised cursor that accepts a member id
-- and lists every book that member has ever issued,
-- along with the issue date.
--
-- Use a three-table join.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts member_id as a parameter.
-- 2. Three tables are joined:
--       LIB_MEMBER
--       BOOK_ISSUE
--       BOOK
-- 3. BOOK_ISSUE connects members with books.
-- 4. TO_CHAR() is used to format the issue date.
-- 5. &member_id is a SQL*Plus substitution variable.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- Three-table JOIN:
    -- LIB_MEMBER -> BOOK_ISSUE -> BOOK
    -- ========================================================

    CURSOR c_issued_books (
        p_member_id NUMBER
    ) IS
        SELECT m.member_name,
               b.title,
               bi.issue_date
        FROM lib_member m
        JOIN book_issue bi
            ON m.member_id = bi.member_id
        JOIN book b
            ON bi.book_id = b.book_id
        WHERE m.member_id = p_member_id
        ORDER BY bi.issue_date;


BEGIN

    -- ========================================================
    -- Display the selected member ID.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Member ID : ' || '&member_id'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Open the parameterised cursor using the entered
    -- member ID.
    -- ========================================================

    FOR r_issue IN c_issued_books(&member_id)
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Member : ' || r_issue.member_name
        );

        DBMS_OUTPUT.PUT_LINE(
            'Book   : ' || r_issue.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Issue Date : ' ||
            TO_CHAR(
                r_issue.issue_date,
                'DD-MON-YYYY'
            )
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


END;
/