SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 4
-- 3.4.5 - CURSOR TYPES COMPARISON
--
-- Question:
-- Complete the comparison table for:
--
-- 1. Implicit Cursor
-- 2. Explicit (Simple) Cursor
-- 3. Parameterised Cursor
--
-- Compare them under:
-- 1. Who declares it?
-- 2. Who opens and closes it?
-- 3. Can it be reused with different values?
-- 4. One situation where it is the best choice.
--
-- Student Name : Nikhil tak
-- Roll No      : 50
-- ============================================================


-- ============================================================
-- ANSWER
-- ============================================================


-- ============================================================
-- 1. IMPLICIT CURSOR
-- ============================================================
--
-- Who declares it?
-- Oracle automatically creates and manages the cursor.
--
-- Who opens and closes it?
-- Oracle automatically opens and closes it.
--
-- Can it be reused with different values?
-- It is not explicitly reused like a declared cursor.
-- Each SQL statement is handled automatically by Oracle.
--
-- Best situation:
-- Use it for simple SQL statements such as INSERT, UPDATE,
-- DELETE and SELECT INTO where manual cursor control is
-- not required.
--
-- Example:
--
--     UPDATE book
--     SET price = price + 50
--     WHERE book_id = 101;
--
-- Oracle automatically manages the cursor for this statement.
-- ============================================================


-- ============================================================
-- 2. EXPLICIT (SIMPLE) CURSOR
-- ============================================================
--
-- Who declares it?
-- The PL/SQL programmer declares it explicitly.
--
-- Who opens and closes it?
-- The programmer opens and closes it when using the
-- OPEN / FETCH / CLOSE style.
--
-- Can it be reused with different values?
-- The cursor query is fixed, so it cannot receive different
-- values unless the query itself uses variables or parameters.
--
-- Best situation:
-- Use it when multiple rows from one fixed query need to be
-- processed one at a time with manual control.
--
-- Example:
--
--     CURSOR c_book IS
--         SELECT book_id, title
--         FROM book;
--
--     OPEN c_book;
--     FETCH c_book INTO ...;
--     CLOSE c_book;
-- ============================================================


-- ============================================================
-- 3. PARAMETERISED CURSOR
-- ============================================================
--
-- Who declares it?
-- The PL/SQL programmer declares it with one or more
-- parameters.
--
-- Who opens and closes it?
-- The programmer controls it when using OPEN / FETCH / CLOSE.
-- A cursor FOR LOOP can also automatically manage opening
-- and closing.
--
-- Can it be reused with different values?
-- YES.
--
-- The same cursor can be used with different parameter values.
--
-- Best situation:
-- Use it when the same query logic is required with different
-- input values.
--
-- Example:
--
--     CURSOR c_book(p_category VARCHAR2) IS
--         SELECT book_id, title
--         FROM book
--         WHERE category = p_category;
--
--     c_book('Database');
--     c_book('Programming');
-- ============================================================


-- ============================================================
-- COMPARISON TABLE
-- ============================================================
--
-- | Cursor Type       | Who Declares? | Who Opens/Closes? |
-- |-------------------|---------------|-------------------|
-- | Implicit          | Oracle        | Oracle            |
-- | Explicit Simple   | Programmer    | Programmer        |
-- | Parameterised     | Programmer    | Programmer /      |
-- |                   |               | FOR LOOP handles  |
--
--
-- | Cursor Type       | Reusable with Different Values? |
-- |-------------------|---------------------------------|
-- | Implicit          | Not explicitly reusable         |
-- | Explicit Simple   | No parameters                   |
-- | Parameterised     | YES                             |
--
--
-- | Cursor Type       | Best Use                         |
-- |-------------------|---------------------------------|
-- | Implicit          | Simple SQL operations            |
-- | Explicit Simple   | Process rows from fixed query    |
-- | Parameterised     | Same query with different input  |
--
-- ============================================================


-- ============================================================
-- SHORT CONCLUSION
-- ============================================================
--
-- Implicit cursor:
-- Oracle manages everything automatically.
--
-- Explicit cursor:
-- Programmer gets manual control over a fixed query.
--
-- Parameterised cursor:
-- Programmer can reuse the same cursor with different values.
--
-- ============================================================


DBMS_OUTPUT.PUT_LINE(
    'Cursor comparison answer completed.'
);

/