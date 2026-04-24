WITH CAST_CTE AS (
    SELECT
        TRY_TO_TIMESTAMP(STARTED_AT, 'YYYY-MM-DD HH24:MI:SS.FF9') AS STARTED_AT
    FROM {{ source('demo', 'bike') }}
    WHERE STARTED_AT != 'stoptime'
),

CTE AS (
    SELECT
        STARTED_AT,
        DATE(STARTED_AT) AS DATE_STARTED_AT,
        HOUR(STARTED_AT) AS HOUR_STARTED_AT,
        CASE
            WHEN DAYNAME(STARTED_AT) IN ('Sat', 'Sun')
            THEN 'WEEKEND'
            ELSE 'BUSINESS DAY'
        END AS DAY_TYPE,
        MONTH(STARTED_AT),
        CASE 
            WHEN MONTH(STARTED_AT) IN (12,1,2)
            THEN 'WINTER'
            WHEN MONTH(STARTED_AT) IN (3,4,5)
            THEN 'SPRING'
            WHEN MONTH(STARTED_AT) IN (6,7,8)
            THEN 'SUMMER'
            WHEN MONTH(STARTED_AT) IN (9,10,11)
            THEN 'FALL'
        END AS SEASON

    FROM CAST_CTE
)

SELECT *
FROM CTE