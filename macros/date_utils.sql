{% macro get_season(x) %}

CASE 
    WHEN MONTH({{x}}) IN (12,1,2)
    THEN 'WINTER'
    WHEN MONTH({{x}}) IN (3,4,5)
    THEN 'SPRING'
    WHEN MONTH({{x}}) IN (6,7,8)
    THEN 'SUMMER'
    WHEN MONTH({{x}}) IN (9,10,11)
    THEN 'FALL'
END

{% endmacro %}
{% macro day_type(x) %}
CASE
    WHEN DAYNAME({{x}}) IN ('Sat', 'Sun')
    THEN 'WEEKEND'
    ELSE 'BUSINESS DAY'
END
{% endmacro %}