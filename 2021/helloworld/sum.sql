DROP TABLE IF EXISTS RESULT;
CREATE TABLE RESULT(
    A INTEGER,
    B INTEGER
);

.separator " " "\n"
.import helloworld/input.txt RESULT

SELECT A + B FROM RESULT;
