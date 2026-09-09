SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 3
-- 3.3.2 - PARAMETERISED CURSOR - PUBLISHER
--
-- Question:
-- Write a parameterised cursor that accepts a publisher name
-- and lists the title and price of every book published by
-- that publisher.
--
-- Make the comparison case-insensitive using UPPER().
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. The cursor accepts the publisher name as a parameter.
-- 2. BOOK and PUBLISHER are joined using pub_id.
-- 3. UPPER() makes the publisher comparison case-insensitive.
-- 4. The cursor can be reused with different publisher names.
-- ============================================================


DECLARE

    -- ========================================================
    -- Parameterised cursor
    --
    -- No size is given to the cursor parameter.
    -- ========================================================

    CURSOR c_book (p_publisher VARCHAR2) IS
        SELECT b.title,
               b.price
        FROM book b
        JOIN publisher p
            ON b.pub_id = p.pub_id
        WHERE UPPER(p.pub_name) = UPPER(p_publisher)
        ORDER BY b.book_id;


BEGIN

    -- ========================================================
    -- Display books for the publisher entered by the user.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        'Publisher : ' || '&publisher_name'
    );

    DBMS_OUTPUT.PUT_LINE(
        '----------------------------------------------'
    );


    FOR r_book IN c_book('&publisher_name')
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Title : ' || r_book.title
            || ' | Price : Rs.' || r_book.price
        );

    END LOOP;


END;
/