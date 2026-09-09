SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.9 - PARAMETERISED CURSOR - BOOKS ISSUED BY MONTH
--
-- Question:
-- Write a parameterised cursor that accepts a month number
-- (1-12) and lists all books issued in that month of 2026.
--
-- Use:
--     EXTRACT(MONTH FROM issue_date)
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts the month number as a parameter.
-- 2. EXTRACT(MONTH FROM issue_date) gets the month number.
-- 3. EXTRACT(YEAR FROM issue_date) ensures that only 2026
--    records are selected.
-- 4. The book title is obtained using BOOK_ISSUE and BOOK.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    -- ========================================================

    CURSOR c_issue (
        p_month NUMBER
    ) IS
        SELECT bi.issue_id,
               b.book_id,
               b.title,
               bi.issue_date
        FROM book_issue bi
        JOIN book b
            ON bi.book_id = b.book_id
        WHERE EXTRACT(MONTH FROM bi.issue_date) = p_month
          AND EXTRACT(YEAR FROM bi.issue_date) = 2026
        ORDER BY bi.issue_date;


BEGIN

    -- ========================================================
    -- Test with month number 6 = June
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Books issued in month 6 (June) - 2026'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_issue IN c_issue(6)
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Issue ID : ' || r_issue.issue_id
            || ' | Book ID : ' || r_issue.book_id
        );

        DBMS_OUTPUT.PUT_LINE(
            'Book     : ' || r_issue.title
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