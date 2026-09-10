SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.1 - CURSOR %ROWCOUNT INVALID CURSOR DEBUG
--
-- Question:
-- Study the given block. It compiles successfully but fails
-- at run time with ORA-01001: cursor number is invalid or
-- does not exist.
--
-- Identify:
-- 1. The exact cause.
-- 2. The line that raises the error.
-- 3. Rewrite the block correctly.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
-- ============================================================


-- ============================================================
-- ANSWER
--
-- ERROR:
-- ORA-01001: invalid cursor
--
-- EXACT CAUSE:
-- The cursor is used inside a cursor FOR LOOP.
--
-- A cursor FOR LOOP automatically:
-- 1. Opens the cursor.
-- 2. Fetches the rows.
-- 3. Closes the cursor when the loop ends.
--
-- Therefore, after the FOR LOOP finishes, c_book is already
-- closed.
--
-- The following line tries to access %ROWCOUNT after the
-- cursor has been automatically closed:
--
--     IF c_book%ROWCOUNT = 0 THEN
--
-- This line raises ORA-01001.
--
-- The CLOSE c_book statement would also be incorrect because
-- the cursor FOR LOOP has already closed the cursor.
--
-- CORRECT SOLUTION:
-- Use a BOOLEAN flag inside the loop to determine whether
-- any row was found.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    -- ========================================================

    CURSOR c_book (
        p_cat VARCHAR2
    ) IS
        SELECT book_id,
               title
        FROM book
        WHERE category = p_cat
        ORDER BY book_id;


    -- ========================================================
    -- Flag to check whether at least one book was found.
    -- ========================================================

    v_found BOOLEAN := FALSE;


BEGIN

    -- ========================================================
    -- Process books in the Database category.
    -- ========================================================

    FOR r_book IN c_book('Database')
    LOOP

        -- A row has been found.
        v_found := TRUE;


        DBMS_OUTPUT.PUT_LINE(
            r_book.book_id
            || ' - '
            || r_book.title
        );

    END LOOP;


    -- ========================================================
    -- Check whether the cursor returned any rows.
    --
    -- We use the BOOLEAN flag instead of c_book%ROWCOUNT
    -- because the cursor is already closed here.
    -- ========================================================

    IF NOT v_found THEN

        DBMS_OUTPUT.PUT_LINE(
            'No books found'
        );

    END IF;


END;
/
