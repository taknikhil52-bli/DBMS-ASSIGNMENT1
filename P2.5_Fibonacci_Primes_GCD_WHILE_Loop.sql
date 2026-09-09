SET SERVEROUTPUT ON;
SET SQLBLANKLINES ON;

-- ============================================================
-- P2.5 - FIBONACCI, PRIMES AND GCD - WHILE LOOP
--
-- Question:
--
-- Part A:
-- Print first N Fibonacci numbers.
-- N = 5 + roll_no MOD 8
--
-- Part B:
-- Check whether the Nth Fibonacci number is prime using
-- an inner WHILE loop.
--
-- Part C:
-- Print all prime numbers between 1 and 100.
-- Count the total number of primes.
--
-- Part D:
-- Find GCD of two numbers using the Euclidean algorithm:
--
-- WHILE b != 0 LOOP
--     r := MOD(a,b);
--     a := b;
--     b := r;
-- END LOOP;
--
-- Part E:
-- Check whether a number is a perfect number.
-- Example:
--     6 = 1 + 2 + 3
--
-- Key points:
-- 1. WHILE LOOP continues while its condition is TRUE.
-- 2. MOD() is used to test divisibility.
-- 3. A prime number has exactly two factors: 1 and itself.
-- 4. Fibonacci numbers are generated from the previous
--    two values.
-- 5. Euclidean algorithm efficiently calculates GCD.
-- 6. A perfect number equals the sum of its proper divisors.
--
-- Personalised details:
-- Name    : Nikhil tak
-- Roll No : 50
--
-- N:
-- 5 + (50 MOD 8)
-- = 5 + 1
-- = 6
--
-- Fibonacci:
-- 0, 1, 1, 2, 3, 5
--
-- Nth Fibonacci = 5
--
-- GCD values:
-- a = 50 * 12 = 396
-- b = 50 * 8  = 264
-- ============================================================

DECLARE

    -- --------------------------------------------------------
    -- Student details
    -- --------------------------------------------------------

    v_name VARCHAR2(50) := 'Nikhil tak';
    v_roll NUMBER := 50;


    -- --------------------------------------------------------
    -- Fibonacci variables
    -- --------------------------------------------------------

    v_n NUMBER;
    v_count NUMBER;

    v_fib_a NUMBER := 0;
    v_fib_b NUMBER := 1;
    v_fib_next NUMBER;

    v_nth_fib NUMBER;


    -- --------------------------------------------------------
    -- Prime-checking variables
    -- --------------------------------------------------------

    v_number NUMBER;
    v_divisor NUMBER;
    v_is_prime BOOLEAN;


    -- --------------------------------------------------------
    -- Prime counting
    -- --------------------------------------------------------

    v_prime_count NUMBER := 0;


    -- --------------------------------------------------------
    -- GCD variables
    -- --------------------------------------------------------

    v_gcd_a NUMBER := 50 * 12;
    v_gcd_b NUMBER := 50 * 8;
    v_remainder NUMBER;


    -- --------------------------------------------------------
    -- Perfect number variables
    -- --------------------------------------------------------

    v_perfect_number NUMBER := 6;
    v_divisor_sum NUMBER := 0;
    v_test_divisor NUMBER := 1;

BEGIN

    -- ========================================================
    -- Calculate N.
    -- ========================================================

    v_n := 5 + MOD(v_roll, 8);


    -- ========================================================
    -- PART A
    -- Print first N Fibonacci numbers.
    --
    -- For Roll No. 50:
    -- N = 6
    --
    -- Output:
    -- 0 1 1 2 3 5
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART A - FIBONACCI SERIES'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'N = ' || v_n
    );

    DBMS_OUTPUT.PUT('Fibonacci: ');

    v_count := 1;

    WHILE v_count <= v_n LOOP

        DBMS_OUTPUT.PUT(v_fib_a);

        IF v_count < v_n THEN
            DBMS_OUTPUT.PUT(', ');
        END IF;

        -- Calculate next Fibonacci number.
        v_fib_next := v_fib_a + v_fib_b;

        v_fib_a := v_fib_b;
        v_fib_b := v_fib_next;

        v_count := v_count + 1;

    END LOOP;

    DBMS_OUTPUT.NEW_LINE;


    -- --------------------------------------------------------
    -- The last generated value is stored separately.
    --
    -- For N = 6:
    -- Nth Fibonacci = 5
    --
    -- We reset the values and calculate it again so that
    -- the logic remains clear and independent.
    -- --------------------------------------------------------

    v_fib_a := 0;
    v_fib_b := 1;
    v_count := 1;

    WHILE v_count < v_n LOOP

        v_fib_next := v_fib_a + v_fib_b;

        v_fib_a := v_fib_b;
        v_fib_b := v_fib_next;

        v_count := v_count + 1;

    END LOOP;

    v_nth_fib := v_fib_a;


    -- ========================================================
    -- PART B
    -- Check whether the Nth Fibonacci number is prime.
    --
    -- An inner WHILE loop tests divisibility.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART B - NTH FIBONACCI PRIME CHECK'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Nth Fibonacci Number : ' || v_nth_fib
    );


    -- Numbers less than 2 are not prime.
    IF v_nth_fib < 2 THEN

        v_is_prime := FALSE;

    ELSE

        v_is_prime := TRUE;

        v_divisor := 2;

        -- ----------------------------------------------------
        -- Inner WHILE loop checks divisibility.
        -- ----------------------------------------------------

        WHILE v_divisor <= TRUNC(SQRT(v_nth_fib)) LOOP

            IF MOD(v_nth_fib, v_divisor) = 0 THEN

                v_is_prime := FALSE;

            END IF;

            v_divisor := v_divisor + 1;

        END LOOP;

    END IF;


    IF v_is_prime THEN

        DBMS_OUTPUT.PUT_LINE(
            'Result               : PRIME'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Result               : NOT PRIME'
        );

    END IF;


    -- ========================================================
    -- PART C
    -- Print all primes between 1 and 100.
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART C - PRIME NUMBERS FROM 1 TO 100'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    v_number := 2;

    WHILE v_number <= 100 LOOP

        v_is_prime := TRUE;

        v_divisor := 2;

        -- ----------------------------------------------------
        -- Test current number for primality.
        -- ----------------------------------------------------

        WHILE v_divisor <= TRUNC(SQRT(v_number)) LOOP

            IF MOD(v_number, v_divisor) = 0 THEN

                v_is_prime := FALSE;

            END IF;

            v_divisor := v_divisor + 1;

        END LOOP;


        IF v_is_prime THEN

            DBMS_OUTPUT.PUT(
                v_number || ' '
            );

            v_prime_count :=
                v_prime_count + 1;

        END IF;


        v_number := v_number + 1;

    END LOOP;

    DBMS_OUTPUT.NEW_LINE;

    DBMS_OUTPUT.PUT_LINE(
        'Total Prime Numbers : ' ||
        v_prime_count
    );


    -- ========================================================
    -- PART D
    -- GCD using Euclidean Algorithm.
    --
    -- WHILE b != 0:
    --     r = MOD(a,b)
    --     a = b
    --     b = r
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART D - GCD USING EUCLIDEAN ALGORITHM'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'First Number  : ' || v_gcd_a
    );

    DBMS_OUTPUT.PUT_LINE(
        'Second Number : ' || v_gcd_b
    );


    WHILE v_gcd_b <> 0 LOOP

        v_remainder :=
            MOD(v_gcd_a, v_gcd_b);

        v_gcd_a := v_gcd_b;

        v_gcd_b := v_remainder;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(
        'GCD           : ' || v_gcd_a
    );


    -- ========================================================
    -- PART E
    -- Perfect Number Check.
    --
    -- A perfect number equals the sum of its proper divisors.
    --
    -- For 6:
    -- 1 + 2 + 3 = 6
    -- ========================================================

    DBMS_OUTPUT.PUT_LINE(
        CHR(10) ||
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'PART E - PERFECT NUMBER CHECK'
    );

    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Number : ' || v_perfect_number
    );


    v_test_divisor := 1;
    v_divisor_sum := 0;


    WHILE v_test_divisor <
          v_perfect_number LOOP

        IF MOD(
            v_perfect_number,
            v_test_divisor
        ) = 0 THEN

            v_divisor_sum :=
                v_divisor_sum + v_test_divisor;

        END IF;

        v_test_divisor :=
            v_test_divisor + 1;

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(
        'Sum of Proper Divisors : ' ||
        v_divisor_sum
    );


    IF v_divisor_sum = v_perfect_number THEN

        DBMS_OUTPUT.PUT_LINE(
            'Result : PERFECT NUMBER'
        );

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Result : NOT A PERFECT NUMBER'
        );

    END IF;


    DBMS_OUTPUT.PUT_LINE(
        '================================================'
    );

END;
/