SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.10 - PARAMETERISED CURSOR - OVERDUE FINE
--
-- Question:
-- Write a parameterised cursor that accepts a number of days
-- and lists every issue that is still not returned and is
-- older than that many days.
--
-- For each row:
-- 1. Display issue ID
-- 2. Display book title
-- 3. Display issue date
-- 4. Calculate overdue days
-- 5. Calculate fine at Rs.2 per overdue day
--
-- Display the total fine payable at the end.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. return_date IS NULL identifies books that are not returned.
-- 2. TRUNC(SYSDATE - issue_date) calculates completed days.
-- 3. The issue must be older than the number of days supplied.
-- 4. Overdue days = total days - allowed days.
-- 5. Fine = overdue days * Rs.2.
-- 6. A running variable stores the total fine.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- p_days = allowed number of days.
    -- Only books older than this value are selected.
    -- ========================================================

    CURSOR c_overdue (
        p_days NUMBER
    ) IS
        SELECT bi.issue_id,
               bi.book_id,
               b.title,
               bi.issue_date
        FROM book_issue bi
        JOIN book b
            ON bi.book_id = b.book_id
        WHERE bi.return_date IS NULL
          AND TRUNC(SYSDATE - bi.issue_date) > p_days
        ORDER BY bi.issue_date;


    -- ========================================================
    -- Variables
    -- ========================================================

    v_total_days   NUMBER;
    v_overdue_days NUMBER;
    v_fine         NUMBER;
    v_total_fine   NUMBER := 0;

    v_days NUMBER := &days;


BEGIN

    -- ========================================================
    -- Display input information.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        '          OVERDUE FINE REPORT'
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        'Allowed Days : ' || v_days
    );

    DBMS_OUTPUT.PUT_LINE(
        'Fine Rate    : Rs.2 per overdue day'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    -- ========================================================
    -- Open the parameterised cursor.
    -- ========================================================

    FOR r_issue IN c_overdue(v_days)
    LOOP

        -- ----------------------------------------------------
        -- Calculate total completed days since issue.
        -- ----------------------------------------------------

        v_total_days :=
            TRUNC(SYSDATE - r_issue.issue_date);


        -- ----------------------------------------------------
        -- Calculate ONLY the days beyond the allowed period.
        --
        -- Example:
        -- Total days  = 70
        -- Allowed     = 30
        -- Overdue     = 40 days
        -- ----------------------------------------------------

        v_overdue_days :=
            v_total_days - v_days;


        -- ----------------------------------------------------
        -- Calculate fine.
        -- ----------------------------------------------------

        v_fine :=
            v_overdue_days * 2;


        -- ----------------------------------------------------
        -- Add current fine to total fine.
        -- ----------------------------------------------------

        v_total_fine :=
            v_total_fine + v_fine;


        -- ----------------------------------------------------
        -- Display issue details.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Issue ID       : ' || r_issue.issue_id
        );

        DBMS_OUTPUT.PUT_LINE(
            'Book           : ' || r_issue.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Issue Date     : ' ||
            TO_CHAR(
                r_issue.issue_date,
                'DD-MON-YYYY'
            )
        );

        DBMS_OUTPUT.PUT_LINE(
            'Total Days     : ' || v_total_days
        );

        DBMS_OUTPUT.PUT_LINE(
            'Overdue Days   : ' || v_overdue_days
        );

        DBMS_OUTPUT.PUT_LINE(
            'Fine           : Rs.' || v_fine
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


    -- ========================================================
    -- Display total fine.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Total Fine Payable : Rs.' ||
        v_total_fine
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );


END;
/