SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.7 - CURSOR %ISOPEN CHECK
--
-- Question:
-- Write a block that uses %ISOPEN to check whether the cursor
-- is already open before opening it, and prints:
--
--     'Cursor already open'
--
-- if it is.
--
-- Close the cursor and verify that %ISOPEN now returns FALSE.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. %ISOPEN checks whether a cursor is currently open.
-- 2. Before OPEN, %ISOPEN returns FALSE.
-- 3. After OPEN, %ISOPEN returns TRUE.
-- 4. After CLOSE, %ISOPEN returns FALSE again.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title
        FROM book
        ORDER BY book_id;


BEGIN

    -- ========================================================
    -- STEP 1: Check whether the cursor is already open.
    -- ========================================================

    IF c_book%ISOPEN THEN

        DBMS_OUTPUT.PUT_LINE(
            'Cursor already open'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Cursor is not open'
        );

    END IF;


    -- ========================================================
    -- STEP 2: Open the cursor.
    -- ========================================================

    OPEN c_book;


    -- ========================================================
    -- STEP 3: Verify that the cursor is now open.
    -- ========================================================

    IF c_book%ISOPEN THEN

        DBMS_OUTPUT.PUT_LINE(
            'Cursor is now OPEN'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Cursor is not open'
        );

    END IF;


    -- ========================================================
    -- STEP 4: Close the cursor.
    -- ========================================================

    CLOSE c_book;


    -- ========================================================
    -- STEP 5: Verify that the cursor is closed.
    -- ========================================================

    IF c_book%ISOPEN THEN

        DBMS_OUTPUT.PUT_LINE(
            'Cursor is still OPEN'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Cursor is now CLOSED'
        );

    END IF;


END;
/