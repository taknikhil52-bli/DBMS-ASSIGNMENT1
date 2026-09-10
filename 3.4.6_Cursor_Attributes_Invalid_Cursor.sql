SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.6 - CURSOR ATTRIBUTES ON AN UNOPENED CURSOR
--
-- Question:
-- Explain with one example each why %FOUND, %NOTFOUND,
-- %ROWCOUNT and %ISOPEN behave differently when used on
-- a cursor that has not been opened.
--
-- Which one does NOT raise ORA-01001?
-- What does it return instead?
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. %FOUND on an unopened explicit cursor raises
--    ORA-01001 (invalid cursor).
--
-- 2. %NOTFOUND on an unopened explicit cursor raises
--    ORA-01001 (invalid cursor).
--
-- 3. %ROWCOUNT on an unopened explicit cursor raises
--    ORA-01001 (invalid cursor).
--
-- 4. %ISOPEN is the exception.
--    It does NOT raise ORA-01001.
--    It returns FALSE when the cursor is not open.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor declaration
    --
    -- IMPORTANT:
    -- The cursor is deliberately NOT opened.
    -- ========================================================

    CURSOR c_book IS
        SELECT book_id, title
        FROM book
        ORDER BY book_id;


BEGIN

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );

    DBMS_OUTPUT.PUT_LINE(
        'CURSOR ATTRIBUTE TEST - UNOPENED CURSOR'
    );

    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );


    -- ========================================================
    -- 1. %FOUND
    --
    -- The cursor has not been opened.
    -- Therefore %FOUND raises ORA-01001.
    -- ========================================================

    BEGIN

        IF c_book%FOUND THEN

            DBMS_OUTPUT.PUT_LINE(
                '%FOUND : TRUE'
            );

        ELSE

            DBMS_OUTPUT.PUT_LINE(
                '%FOUND : FALSE'
            );

        END IF;

    EXCEPTION

        WHEN INVALID_CURSOR THEN

            DBMS_OUTPUT.PUT_LINE(
                '%FOUND : ORA-01001 (invalid cursor)'
            );

    END;


    -- ========================================================
    -- 2. %NOTFOUND
    --
    -- The cursor has not been opened.
    -- Therefore %NOTFOUND raises ORA-01001.
    -- ========================================================

    BEGIN

        IF c_book%NOTFOUND THEN

            DBMS_OUTPUT.PUT_LINE(
                '%NOTFOUND : TRUE'
            );

        ELSE

            DBMS_OUTPUT.PUT_LINE(
                '%NOTFOUND : FALSE'
            );

        END IF;

    EXCEPTION

        WHEN INVALID_CURSOR THEN

            DBMS_OUTPUT.PUT_LINE(
                '%NOTFOUND : ORA-01001 (invalid cursor)'
            );

    END;


    -- ========================================================
    -- 3. %ROWCOUNT
    --
    -- The cursor has not been opened.
    -- Therefore %ROWCOUNT raises ORA-01001.
    -- ========================================================

    BEGIN

        DBMS_OUTPUT.PUT_LINE(
            '%ROWCOUNT : ' || c_book%ROWCOUNT
        );

    EXCEPTION

        WHEN INVALID_CURSOR THEN

            DBMS_OUTPUT.PUT_LINE(
                '%ROWCOUNT : ORA-01001 (invalid cursor)'
            );

    END;


    -- ========================================================
    -- 4. %ISOPEN
    --
    -- This is the exception.
    --
    -- %ISOPEN can safely be checked before opening the cursor.
    -- Since c_book is not open, it returns FALSE.
    -- ========================================================

    IF c_book%ISOPEN THEN

        DBMS_OUTPUT.PUT_LINE(
            '%ISOPEN : TRUE'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            '%ISOPEN : FALSE'
        );

    END IF;


    DBMS_OUTPUT.PUT_LINE(
        '=============================================='
    );


END;
/
