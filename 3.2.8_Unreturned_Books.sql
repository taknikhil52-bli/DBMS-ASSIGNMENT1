SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.8 - UNRETURNED BOOKS
--
-- Question:
-- List all books that are currently not returned
-- (return_date IS NULL).
--
-- Display:
-- 1. Issue ID
-- 2. Book ID
-- 3. Issue Date
--
-- If the cursor returns no rows, display:
--     All books returned
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. NULL must be checked using IS NULL.
-- 2. A cursor FOR LOOP processes each matching issue.
-- 3. A BOOLEAN flag is used to detect whether at least
--    one row was found.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor for currently unreturned books.
    -- ========================================================

    CURSOR c_unreturned IS
        SELECT issue_id, book_id, issue_date
        FROM book_issue
        WHERE return_date IS NULL
        ORDER BY issue_id;


    -- ========================================================
    -- Flag to check whether any record was found.
    -- ========================================================

    v_found BOOLEAN := FALSE;


BEGIN

    -- ========================================================
    -- Process all unreturned books.
    -- ========================================================

    FOR r_issue IN c_unreturned
    LOOP

        -- A matching record has been found.
        v_found := TRUE;


        -- ----------------------------------------------------
        -- Display issue details.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            'Issue ID  : ' || r_issue.issue_id
            || ' | Book ID : ' || r_issue.book_id
            || ' | Issue Date : '
            || TO_CHAR(r_issue.issue_date, 'DD-MON-YYYY')
        );

    END LOOP;


    -- ========================================================
    -- If no records were found, display the required message.
    -- ========================================================

    IF NOT v_found THEN

        DBMS_OUTPUT.PUT_LINE(
            'All books returned'
        );

    END IF;


END;
/