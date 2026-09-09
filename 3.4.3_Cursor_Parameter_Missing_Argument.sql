SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.3 - CURSOR %ROWCOUNT FETCH BEHAVIOUR
--
-- Question:
-- What will the following block print, and why does the
-- second PUT_LINE show a different number from the first?
-- Predict the output before running it.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. %ROWCOUNT shows the number of rows successfully fetched.
-- 2. It starts at 0 before the first successful FETCH.
-- 3. It increases by 1 after every successful FETCH.
-- 4. The final %ROWCOUNT equals the total number of rows
--    successfully fetched.
-- 5. The final unsuccessful FETCH does NOT increase
--    %ROWCOUNT.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor selects books whose price is greater than 600.
    -- ========================================================

    CURSOR c IS
        SELECT title
        FROM book
        WHERE price > 600
        ORDER BY book_id;


    v_title book.title%TYPE;


BEGIN

    -- ========================================================
    -- Open cursor.
    -- ========================================================

    OPEN c;


    -- ========================================================
    -- Fetch rows one by one.
    -- ========================================================

    LOOP

        FETCH c
        INTO v_title;


        -- ----------------------------------------------------
        -- Stop when there are no more rows.
        -- ----------------------------------------------------

        EXIT WHEN c%NOTFOUND;


        -- ----------------------------------------------------
        -- Display ROWCOUNT and title.
        -- ----------------------------------------------------

        DBMS_OUTPUT.PUT_LINE(
            c%ROWCOUNT || ' : ' || v_title
        );

    END LOOP;


    -- ========================================================
    -- Display final ROWCOUNT.
    --
    -- There are 7 books with price > 600.
    -- Therefore final ROWCOUNT is 7.
    --
    -- The unsuccessful FETCH used to discover the end does
    -- NOT increase ROWCOUNT.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Final ROWCOUNT = ' || c%ROWCOUNT
    );


    -- ========================================================
    -- Close cursor.
    -- ========================================================

    CLOSE c;


END;
/