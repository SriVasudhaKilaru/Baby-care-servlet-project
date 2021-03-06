/*
 * $Id: dsv-trimming.sql,v 1.1 2007/08/09 03:28:36 unsaved Exp $
 *
 * Tests trimming in DSV imports
 */

/** This is the default on UNIX.
 *  Our *.dsv test files are stored as binaries, so this is required
 *  to run tests on Windows: */
* *DSV_ROW_DELIM = \n

CREATE TABLE t (i INT, r REAL, d DATE, t TIMESTAMP, v VARCHAR, b BOOLEAN);

\m dsv-trimming.dsv

SELECT count(*)  FROM t WHERE i = 31;
*if (*? != 1)
    \q Import of space-embedded INT failed
*end if

SELECT count(*)  FROM t WHERE r = 3.124;
*if (*? != 1)
    \q Import of space-embedded REAL failed
*end if

SELECT count(*)  FROM t WHERE d = '2007-06-07';
*if (*? != 1)
    \q Import of space-embedded DATE failed
*end if

SELECT count(*)  FROM t WHERE t = '2006-05-06 12:30:04';
*if (*? != 1)
    \q Import of space-embedded TIMESTAMP failed
*end if

SELECT count(*)  FROM t WHERE v = '  a B  ';
*if (*? != 1)
    \q Import of space-embedded VARCHAR failed
*end if

/** I dont' know if "IS true" or "= true" is preferred, but the former
 * doesn't work with HSQLDB 1.7.0.7 */
SELECT count(*)  FROM t WHERE b = true;
*if (*? != 1)
    \q Import of space-embedded BOOLEAN failed
*end if


/** Repeat test with some non-default DSV settings */
* *DSV_COL_DELIM = \\
* *DSV_ROW_DELIM = }\n

DELETE FROM t;

\m dsv-trimming-alt.dsv

SELECT count(*)  FROM t WHERE i = 31;
*if (*? != 1)
    \q Import of space-embedded INT failed
*end if

SELECT count(*)  FROM t WHERE r = 3.124;
*if (*? != 1)
    \q Import of space-embedded REAL failed
*end if

SELECT count(*)  FROM t WHERE d = '2007-06-07';
*if (*? != 1)
    \q Import of space-embedded DATE failed
*end if

SELECT count(*)  FROM t WHERE t = '2006-05-06 12:30:04';
*if (*? != 1)
    \q Import of space-embedded TIMESTAMP failed
*end if

SELECT count(*)  FROM t WHERE v = '  a B  ';
*if (*? != 1)
    \q Import of space-embedded VARCHAR failed
*end if

/** I dont' know if "IS true" or "= true" is preferred, but the former
 * doesn't work with HSQLDB 1.7.0.7 */
SELECT count(*)  FROM t WHERE b = true;
*if (*? != 1)
    \q Import of space-embedded BOOLEAN failed
*end if
