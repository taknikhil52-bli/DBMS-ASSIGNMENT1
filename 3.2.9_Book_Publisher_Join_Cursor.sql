SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 2
-- 3.2.9 - BOOK AND PUBLISHER JOIN USING CURSOR
--
-- Question:
-- Using a cursor over a join of BOOK and PUBLISHER,
-- display every book title along with the name of its
-- publisher and the publisher's country.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
--
-- Key points:
-- 1. BOOK and PUBLISHER are joined using pub_id.
-- 2. A cursor is used to process the joined result.
-- 3. The cursor FOR LOOP automatically handles OPEN,
--    FETCH and CLOSE operations.
-- ============================================================


DECLARE

    -- ========================================================
    -- Cursor over BOOK and PUBLISHER tables.
    -- ========================================================

    CURSOR c_book_publisher IS
        SELECT b.title,
               p.pub_name,
               p.country
        FROM book b
        JOIN publisher p
            ON b.pub_id = p.pub_id
        ORDER BY b.book_id;


BEGIN

    -- ========================================================
    -- Display every book with publisher details.
    -- ========================================================

    FOR r_book IN c_book_publisher
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Book    : ' || r_book.title
        );

        DBMS_OUTPUT.PUT_LINE(
            'Publisher : ' || r_book.pub_name
            || ' | Country : ' || r_book.country
        );

        DBMS_OUTPUT.PUT_LINE(
            '----------------------------------------------'
        );

    END LOOP;


END;
/