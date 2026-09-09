SET SERVEROUTPUT ON;

-- ============================================================
-- UNIT 3 - SECTION 1
-- 3.1.1 - LIBRARY SCHEMA SETUP
--
-- Question:
-- Create the Library Management schema required for the
-- PL/SQL Cursor exercises.
--
-- The schema contains four tables:
-- 1. PUBLISHER
-- 2. BOOK
-- 3. LIB_MEMBER
-- 4. BOOK_ISSUE
--
-- PUBLISHER is the parent of BOOK.
-- BOOK_ISSUE is a child of both BOOK and LIB_MEMBER.
--
-- Tables must be created in the given order because
-- foreign key constraints depend on the parent tables.
--
-- After inserting the data, verify:
-- PUBLISHER  = 5 rows
-- BOOK       = 12 rows
-- LIB_MEMBER = 8 rows
-- BOOK_ISSUE = 12 rows
--
-- Student Name : Nikhil tak
-- Roll No      : 50
-- ============================================================


-- ============================================================
-- 1. CREATE PUBLISHER TABLE
-- ============================================================

CREATE TABLE publisher (
    pub_id NUMBER(4),
    pub_name VARCHAR2(40) NOT NULL,
    city VARCHAR2(30),
    country VARCHAR2(30),

    CONSTRAINT pk_publisher
        PRIMARY KEY (pub_id)
);


-- ============================================================
-- 2. CREATE BOOK TABLE
-- ============================================================

CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(60) NOT NULL,
    category VARCHAR2(25),
    price NUMBER(8,2),
    stock NUMBER(4),
    pub_id NUMBER(4),

    CONSTRAINT pk_book
        PRIMARY KEY (book_id),

    CONSTRAINT fk_book_pub
        FOREIGN KEY (pub_id)
        REFERENCES publisher (pub_id)
);


-- ============================================================
-- 3. CREATE LIB_MEMBER TABLE
-- ============================================================

CREATE TABLE lib_member (
    member_id NUMBER(5),
    member_name VARCHAR2(40) NOT NULL,
    course VARCHAR2(20),
    semester NUMBER(1),
    join_date DATE,

    CONSTRAINT pk_member
        PRIMARY KEY (member_id)
);


-- ============================================================
-- 4. CREATE BOOK_ISSUE TABLE
-- ============================================================

CREATE TABLE book_issue (
    issue_id NUMBER(6),
    book_id NUMBER(5),
    member_id NUMBER(5),
    issue_date DATE,
    return_date DATE,
    fine NUMBER(6,2) DEFAULT 0,

    CONSTRAINT pk_issue
        PRIMARY KEY (issue_id),

    CONSTRAINT fk_issue_book
        FOREIGN KEY (book_id)
        REFERENCES book (book_id),

    CONSTRAINT fk_issue_member
        FOREIGN KEY (member_id)
        REFERENCES lib_member (member_id)
);


-- ============================================================
-- 5. INSERT PUBLISHER DATA
-- ============================================================

-- Parent table data is inserted first.

INSERT INTO publisher
VALUES (10, 'Oxford Press', 'London', 'UK');

INSERT INTO publisher
VALUES (20, 'Tech Bharat Pub', 'Pune', 'India');

INSERT INTO publisher
VALUES (30, 'McGraw Hill', 'New York', 'USA');

INSERT INTO publisher
VALUES (40, 'Vidya Prakashan', 'Ahmedabad', 'India');

INSERT INTO publisher
VALUES (50, 'Pearson Global', 'Toronto', 'Canada');


-- ============================================================
-- 6. INSERT BOOK DATA
-- ============================================================

INSERT INTO book
VALUES (101, 'Database System Concepts',
        'Database', 850.00, 12, 30);

INSERT INTO book
VALUES (102, 'Let Us Learn PL/SQL',
        'Database', 420.50, 4, 20);

INSERT INTO book
VALUES (103, 'Operating System Design',
        'OS', 690.00, 8, 30);

INSERT INTO book
VALUES (104, 'Java Complete Reference',
        'Programming', 975.00, 15, 30);

INSERT INTO book
VALUES (105, 'Python for Beginners',
        'Programming', 350.00, 3, 20);

INSERT INTO book
VALUES (106, 'Computer Networks',
        'Networking', 780.00, 6, 10);

INSERT INTO book
VALUES (107, 'Data Structures in C',
        'Programming', 560.00, 2, 40);

INSERT INTO book
VALUES (108, 'Oracle SQL Handbook',
        'Database', 640.00, 9, 10);

INSERT INTO book
VALUES (109, 'Software Engineering',
        'SE', 520.00, 7, 50);

INSERT INTO book
VALUES (110, 'Web Technology Basics',
        'Web', 295.00, 1, 40);

INSERT INTO book
VALUES (111, 'Advanced DBMS',
        'Database', 1150.00, 5, 50);

INSERT INTO book
VALUES (112, 'Cloud Computing Essentials',
        'Networking', 880.00, 4, 10);


-- ============================================================
-- 7. INSERT LIBRARY MEMBER DATA
-- ============================================================

INSERT INTO lib_member
VALUES (1, 'Riya Shah',
        'MSc IT', 1, DATE '2026-01-10');

INSERT INTO lib_member
VALUES (2, 'Arjun Mehta',
        'MSc IT', 3, DATE '2025-07-22');

INSERT INTO lib_member
VALUES (3, 'Neha Patel',
        'MCA', 2, DATE '2026-02-05');

INSERT INTO lib_member
VALUES (4, 'Karan Joshi',
        'MCA', 4, DATE '2025-06-15');

INSERT INTO lib_member
VALUES (5, 'Sneha Desai',
        'BCA', 2, DATE '2026-03-01');

INSERT INTO lib_member
VALUES (6, 'Vivek Nair',
        'MSc IT', 3, DATE '2025-12-11');

INSERT INTO lib_member
VALUES (7, 'Ananya Rao',
        'BCA', 5, DATE '2026-01-28');

INSERT INTO lib_member
VALUES (8, 'Manav Trivedi',
        'MCA', 2, DATE '2025-08-09');


-- ============================================================
-- 8. INSERT BOOK ISSUE DATA
-- ============================================================

INSERT INTO book_issue
VALUES (5001, 101, 1,
        DATE '2026-06-01',
        DATE '2026-06-12', 0);

INSERT INTO book_issue
VALUES (5002, 104, 2,
        DATE '2026-06-03',
        NULL, 0);

INSERT INTO book_issue
VALUES (5003, 102, 3,
        DATE '2026-06-05',
        DATE '2026-06-30', 50);

INSERT INTO book_issue
VALUES (5004, 107, 1,
        DATE '2026-06-10',
        NULL, 0);

INSERT INTO book_issue
VALUES (5005, 111, 4,
        DATE '2026-06-11',
        DATE '2026-06-20', 0);

INSERT INTO book_issue
VALUES (5006, 103, 5,
        DATE '2026-06-15',
        NULL, 0);

INSERT INTO book_issue
VALUES (5007, 108, 2,
        DATE '2026-06-18',
        DATE '2026-07-15', 90);

INSERT INTO book_issue
VALUES (5008, 106, 6,
        DATE '2026-07-01',
        NULL, 0);

INSERT INTO book_issue
VALUES (5009, 101, 7,
        DATE '2026-07-04',
        DATE '2026-07-14', 0);

INSERT INTO book_issue
VALUES (5010, 112, 8,
        DATE '2026-07-09',
        NULL, 0);

INSERT INTO book_issue
VALUES (5011, 105, 3,
        DATE '2026-07-12',
        DATE '2026-07-19', 0);

INSERT INTO book_issue
VALUES (5012, 109, 4,
        DATE '2026-07-20',
        NULL, 0);


-- ============================================================
-- 9. SAVE THE DATA
-- ============================================================

COMMIT;


-- ============================================================
-- 10. VERIFY THE DATABASE SETUP
--
-- Expected:
--
-- PUBLISHER  = 5
-- BOOK       = 12
-- LIB_MEMBER = 8
-- BOOK_ISSUE = 12
-- ============================================================

SELECT COUNT(*) AS publisher_count
FROM publisher;

SELECT COUNT(*) AS book_count
FROM book;

SELECT COUNT(*) AS member_count
FROM lib_member;

SELECT COUNT(*) AS issue_count
FROM book_issue;


-- ============================================================
-- END OF 3.1.1 - LIBRARY SCHEMA SETUP
-- ============================================================