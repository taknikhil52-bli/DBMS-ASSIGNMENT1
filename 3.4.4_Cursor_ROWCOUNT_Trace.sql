SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.4 - PARAMETERISED CURSOR - MISSING ARGUMENT AND DEFAULT
--
-- Question:
-- A student opens a parameterised cursor as OPEN c_book;
-- without supplying the argument.
--
-- What error appears, and at which stage - compilation or
-- execution?
--
-- How does a DEFAULT value in the parameter change this
-- behaviour?
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. A parameterised cursor normally requires its argument
--    when it is opened.
-- 2. If the required argument is omitted, Oracle raises a
--    compilation error.
-- 3. The error is PLS-00306: wrong number or types of
--    arguments in call to cursor.
-- 4. If the cursor parameter has a DEFAULT value, the
--    argument becomes optional.
-- 5. When the argument is omitted, Oracle uses the DEFAULT
--    value automatically.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor WITHOUT a DEFAULT value.
    -- An argument is mandatory when opening this cursor.
    -- ========================================================

    CURSOR c_book_required (
        p_category VARCHAR2
    ) IS
        SELECT book_id,
               title,
               category
        FROM book
        WHERE category = p_category;


    -- ========================================================
    -- Cursor WITH a DEFAULT value.
    -- The argument becomes optional.
    -- ========================================================

    CURSOR c_book_default (
        p_category VARCHAR2 DEFAULT 'Database'
    ) IS
        SELECT book_id,
               title,
               category
        FROM book
        WHERE category = p_category;


BEGIN

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        'PARAMETERISED CURSOR - MISSING ARGUMENT'
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );


    -- ========================================================
    -- PART 1
    --
    -- If the following statement is uncommented:
    --
    -- OPEN c_book_required;
    --
    -- Oracle gives:
    --
    -- PLS-00306: wrong number or types of arguments in call
    --            to 'C_BOOK_REQUIRED'
    --
    -- This is detected at COMPILE TIME because the required
    -- cursor parameter has not been supplied.
    --
    -- Therefore the statement is intentionally commented out
    -- so that this demonstration block can compile.
    -- ========================================================


    -- OPEN c_book_required;


    DBMS_OUTPUT.PUT_LINE(
        'Without DEFAULT : argument is mandatory.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Missing argument : PLS-00306'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Stage            : Compilation'
    );


    -- ========================================================
    -- PART 2
    --
    -- Cursor has DEFAULT 'Database'.
    -- Therefore OPEN without an argument is valid.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'With DEFAULT value:'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Opening cursor without argument...'
    );


    FOR r_book IN c_book_default
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            r_book.book_id ||
            ' - ' ||
            r_book.title ||
            ' - ' ||
            r_book.category
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );

    DBMS_OUTPUT.PUT_LINE(
        'DEFAULT value used : Database'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Result             : Cursor opens successfully'
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );


END;
/