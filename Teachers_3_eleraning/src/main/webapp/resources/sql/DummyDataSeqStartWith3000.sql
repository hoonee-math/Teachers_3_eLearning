-- 1. 기존 데이터와 시퀀스 초기화
-- 테이블 데이터 삭제 (참조 무결성 고려한 순서)
BEGIN
    -- 자식 테이블 데이터 먼저 삭제
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SCHEDULE_EVENT3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MEMBER_LECTURE3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE VIDEO3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE LECTURE3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE COURSE3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PAYMENT_STATUS_HISTORY3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PAYMENT_CANCELLATIONS3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE PAYMENTS3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE CART3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE LIKE3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE COMMENT3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE FILE3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE POST3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE TEACHERS3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE STUDENTS3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MEMBER3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE BOARD_CATEGORY3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE COURSE_CATEGORY3';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE SUBJECT3';
END;
/

-- 시퀀스 삭제 및 재생성
DECLARE
    TYPE seq_list_type IS TABLE OF VARCHAR2(50);
    seq_list seq_list_type := seq_list_type(
        'SEQ_MEMBER3_NO', 'SEQ_STUDENT3_NO', 'SEQ_TEACHERS3_NO',
        'SEQ_COURSE3_NO', 'SEQ_LECTURE3_NO', 'SEQ_VIDEO3_NO',
        'SEQ_MEMBER_LECTURE3_NO', 'SEQ_COURSE_REGISTER3_NO',
        'SEQ_COURSE_CATEGORY3_NO', 'SEQ_CART3_NO', 'SEQ_POST3_NO',
        'SEQ_BOARD_CATEGORY3_NO', 'SEQ_FILE3_NO', 'SEQ_COMMENT3_NO',
        'SEQ_IMAGE3_NO', 'SEQ_LIKE3_NO', 'SEQ_PAYMENTS3_NO',
        'SEQ_BOOK3_NO', 'SEQ_PAYMENT_CANCELLATIONS3_NO',
        'SEQ_PAYMENT_STATUS_HISTORY3_NO', 'SEQ_SCHEDULE_EVENT3_NO',
        'SEQ_SUBJECT3_NO'
    );
BEGIN
    FOR i IN 1..seq_list.COUNT LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq_list(i);
        EXCEPTION
            WHEN OTHERS THEN NULL;
        END;
        EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || seq_list(i) || ' START WITH 3000 INCREMENT BY 1';
    END LOOP;
END;
/

-- 2. 과목 카테고리 생성
INSERT INTO SUBJECT3 (SUBJECT_NO, SUBJECT_NAME)
SELECT SEQ_SUBJECT3_NO.NEXTVAL, COLUMN_VALUE
FROM TABLE(sys.odcivarchar2list(
    '국어', '수학', '영어', '과학', '사회', '한국사', '직업', '제2외국어'
));

-- 3. 강좌 카테고리 생성
-- 3. 강좌 카테고리 생성 (대안 방식)
INSERT INTO COURSE_CATEGORY3 VALUES (SEQ_COURSE_CATEGORY3_NO.NEXTVAL, '진도', '학교 진도 따라잡기 프로젝트');
INSERT INTO COURSE_CATEGORY3 VALUES (SEQ_COURSE_CATEGORY3_NO.NEXTVAL, '내신', '학교 시험 대비 강좌');
INSERT INTO COURSE_CATEGORY3 VALUES (SEQ_COURSE_CATEGORY3_NO.NEXTVAL, '모의고사', '모의고사 대비 문제풀이');
INSERT INTO COURSE_CATEGORY3 VALUES (SEQ_COURSE_CATEGORY3_NO.NEXTVAL, '수능', '수능 대비 개념 완성');

-- 4. 선생님 계정 및 정보 생성
DECLARE
    TYPE subject_array IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    v_subjects subject_array;
    v_member_no NUMBER;
    v_teacher_no NUMBER;
BEGIN
    -- 과목 배열 초기화
    v_subjects(1) := '국어';
    v_subjects(2) := '수학';
    v_subjects(3) := '영어';
    v_subjects(4) := '과학';
    v_subjects(5) := '사회';
    v_subjects(6) := '한국사';
    v_subjects(7) := '직업';
    v_subjects(8) := '제2외국어';

    -- 각 과목별 교사 2명씩 생성
    FOR i IN 1..8 LOOP
        FOR j IN 1..2 LOOP
            -- 회원 정보 생성
            v_member_no := SEQ_MEMBER3_NO.NEXTVAL;
            v_teacher_no := SEQ_TEACHERS3_NO.NEXTVAL;
            
            INSERT INTO MEMBER3 (
                MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME,
                EMAIL, PHONE, MEMBER_TYPE, ENROLL_DATE
            ) VALUES (
                v_member_no,
                LOWER(v_subjects(i)) || j,
                '1234',
                CASE j 
                    WHEN 1 THEN '김' 
                    ELSE '이' 
                END || v_subjects(i),
                LOWER(v_subjects(i)) || j || '@honeyT.com',
                '010-' || LPAD(i, 4, '0') || '-' || LPAD(j, 4, '0'),
                2,
                SYSDATE
            );

            -- 교사 정보 생성
            INSERT INTO TEACHERS3 (
                MEMBER_NO, TEACHER_SUBJECT,
                TEACHER_INFO_TITLE, TEACHER_INFO_CONTENT
            ) VALUES (
                v_member_no,
                i,  -- 과목 번호 (1~8)
                v_subjects(i) || ' 전문 강사' || j,
                v_subjects(i) || ' 강의 경력 ' || (j * 5) || '년'
            );
        END LOOP;
    END LOOP;
END;
/

-- 5. 학생 계정 및 정보 생성
DECLARE
    v_member_no NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        -- 회원 정보 생성
        v_member_no := SEQ_MEMBER3_NO.NEXTVAL;
        
        INSERT INTO MEMBER3 (
            MEMBER_NO, MEMBER_ID, MEMBER_PW, MEMBER_NAME,
            EMAIL, PHONE, MEMBER_TYPE, ENROLL_DATE
        ) VALUES (
            v_member_no,
            'student' || i,
            '1234',
            '학생' || i,
            'student' || i || '@test.com',
            '010-' || LPAD(i, 4, '0') || '-' || LPAD(i, 4, '0'),
            1,
            SYSDATE
        );

        -- 학생 정보 생성
        INSERT INTO STUDENTS3 (
            MEMBER_NO,
            GRADE,
            SCHOOL_NO
        ) VALUES (
            v_member_no,
            CASE 
                WHEN i <= 3 THEN 1
                WHEN i <= 6 THEN 2
                ELSE 3
            END,
            i  -- 임시 학교 번호
        );
    END LOOP;
END;
/

-- 6. 강좌 및 강의 생성 (날짜를 현재 기준으로 설정)
DECLARE
    -- 날짜 범위 상수 정의
    c_date_range NUMBER := 10;  -- 현재 날짜 기준 ±10일
    CURSOR teacher_cur IS
        SELECT m.MEMBER_NO, t.TEACHER_SUBJECT
        FROM MEMBER3 m
        JOIN TEACHERS3 t ON m.MEMBER_NO = t.MEMBER_NO
        WHERE m.MEMBER_TYPE = 2
        ORDER BY m.MEMBER_NO;
        
    v_course_no NUMBER;
    v_lecture_no NUMBER;
BEGIN
    FOR teacher_rec IN teacher_cur LOOP
        -- 각 교사별 2개의 강좌 생성
        FOR i IN 1..2 LOOP
            v_course_no := SEQ_COURSE3_NO.NEXTVAL;
            
            -- 강좌 정보 생성
            INSERT INTO COURSE3 (
                COURSE_NO, COURSE_TITLE, COURSE_DESC,
                COURSE_CATEGORY_NO, GRADE, COURSE_PRICE,
                COURSE_PRICE_SALE, COURSE_STATUS, CREATED_AT,
                BEGIN_DATE, END_DATE, TOTAL_LECTURES, MEMBER_NO
            ) VALUES (
                v_course_no,
                '(' || teacher_rec.TEACHER_SUBJECT || ') ' ||
                CASE i 
                    WHEN 1 THEN '개념완성'
                    ELSE '문제풀이'
                END,
                '체계적인 커리큘럼으로 준비한 강좌입니다.',
                MOD(i, 4) + 1,  -- 카테고리 1~4 순환
                MOD(v_course_no, 3) + 1,  -- 학년 1~3 순환
                150000 + (MOD(v_course_no, 5) * 10000),
                10 + MOD(v_course_no, 11),  -- 10~20% 할인
                1,  -- 진행중
                -- 생성일은 현재 날짜 기준 -10일 ~ 현재 사이 랜덤
                SYSDATE - DBMS_RANDOM.VALUE(0, c_date_range),
                -- 시작일은 생성일 이후 +1~3일
                SYSDATE - DBMS_RANDOM.VALUE(0, c_date_range) + DBMS_RANDOM.VALUE(1, 3),
                -- 종료일은 시작일 기준 30일 후
                SYSDATE - DBMS_RANDOM.VALUE(0, c_date_range) + DBMS_RANDOM.VALUE(1, 3) + 30,
                10,
                teacher_rec.MEMBER_NO
            );

            -- 각 강좌별 10개의 강의 생성
            FOR j IN 1..10 LOOP
                v_lecture_no := SEQ_LECTURE3_NO.NEXTVAL;
                
                INSERT INTO LECTURE3 (
                    LECTURE_NO, LECTURE_TITLE, LECTURE_ORDER,
                    LECTURE_DURATION, LECTURE_DESC, LECTURE_STATUS,
                    CREATED_AT, UPDATED_AT, COURSE_NO
                ) VALUES (
                    v_lecture_no,
                    j || '차시 강의',
                    j,
                    60,  -- 60분 강의
                    j || '번째 강의입니다.',
                    CASE 
                        WHEN j <= 5 THEN '1'  -- 공개
                        ELSE '2'  -- 비공개
                    END,
                    -- 강의 생성일은 강좌 생성일과 동일하게 설정
                    SYSDATE - DBMS_RANDOM.VALUE(0, c_date_range),
                    -- 수정일은 생성일 이후
                    SYSDATE - DBMS_RANDOM.VALUE(0, c_date_range/2),
                    v_course_no
                );
            END LOOP;
        END LOOP;
    END LOOP;
END;
/

-- 7. 수강 신청 및 장바구니 더미 데이터 생성
-- 7. 수강 신청 및 장바구니 더미 데이터 생성
DECLARE
    CURSOR student_cur IS
        SELECT MEMBER_NO, GRADE
        FROM STUDENTS3;
        
    CURSOR course_cur (p_grade NUMBER) IS
        SELECT *
        FROM (
            SELECT c.COURSE_NO
            FROM COURSE3 c
            WHERE c.GRADE = p_grade
            ORDER BY DBMS_RANDOM.VALUE
        ) 
        WHERE ROWNUM <= 3;
        
    v_cart_no NUMBER;
    v_register_no NUMBER;
    v_random_days NUMBER;
BEGIN
    -- 각 학생별 처리
    FOR student_rec IN student_cur LOOP
        -- 장바구니에 2개 강좌 추가
        FOR course_rec IN course_cur(student_rec.GRADE) LOOP
            v_cart_no := SEQ_CART3_NO.NEXTVAL;
            v_random_days := FLOOR(DBMS_RANDOM.VALUE(0, 10)); -- 0-10일 사이의 랜덤한 일수
            
            INSERT INTO CART3 (
                CART_NO, 
                CART_ADDED_AT, 
                IS_PAID,
                MEMBER_NO, 
                COURSE_NO
            ) VALUES (
                v_cart_no,
                SYSDATE - NUMTODSINTERVAL(v_random_days, 'DAY'),  -- 날짜 계산을 안전하게 수정
                0,  -- 미결제
                student_rec.MEMBER_NO,
                course_rec.COURSE_NO
            );
        END LOOP;

        -- 수강신청 2개 추가
        FOR course_rec IN course_cur(student_rec.GRADE) LOOP
            v_register_no := SEQ_COURSE_REGISTER3_NO.NEXTVAL;
            v_random_days := FLOOR(DBMS_RANDOM.VALUE(0, 10)); -- 0-10일 사이의 랜덤한 일수
            
            INSERT INTO COURSE_REGISTER3 (
                COURSE_REGISTER_NO, 
                COURSE_REGISTER_DATE,
                PROGRESS_RATE, 
                COMPLETION_STATUS,
                COURSE_NO, 
                MEMBER_NO, 
                COURSE_SCORE
            ) VALUES (
                v_register_no,
                SYSDATE - NUMTODSINTERVAL(v_random_days, 'DAY'),  -- 날짜 계산을 안전하게 수정
                FLOOR(DBMS_RANDOM.VALUE(0, 100)),  -- 랜덤 진도율 (0-100%)
                0,  -- 미수료
                course_rec.COURSE_NO,
                student_rec.MEMBER_NO,
                NULL  -- 아직 평가 없음
            );
        END LOOP;
    END LOOP;
END;
/

-- 데이터 검증 쿼리
SELECT '회원' as TYPE, COUNT(*) as CNT FROM MEMBER3
UNION ALL
SELECT '교사', COUNT(*) FROM TEACHERS3
UNION ALL
SELECT '학생', COUNT(*) FROM STUDENTS3
UNION ALL
SELECT '강좌', COUNT(*) FROM COURSE3
UNION ALL
SELECT '강의', COUNT(*) FROM LECTURE3
UNION ALL
SELECT '장바구니', COUNT(*) FROM CART3
UNION ALL
SELECT '수강신청', COUNT(*) FROM COURSE_REGISTER3;