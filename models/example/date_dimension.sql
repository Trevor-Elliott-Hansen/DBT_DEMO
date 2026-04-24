WITH CAST_CTE AS (
    SELECT
        TRY_TO_TIMESTAMP(STARTED_AT, 'MM/DD/YYYY HH24:MI:SS') AS STARTED_AT
    FROM {{ source('demo', 'bike') }}
    WHERE STARTED_AT != 'stoptime'
),

CTE AS (
    SELECT
        STARTED_AT,
        DATE(STARTED_AT) AS DATE_STARTED_AT,
        HOUR(STARTED_AT) AS HOUR_STARTED_AT,
        {{day_type('STARTED_AT')}} AS DAY_TYPE,
        {{get_season('STARTED_AT')}} AS SEASON

    FROM CAST_CTE
)

SELECT *
FROM CTE