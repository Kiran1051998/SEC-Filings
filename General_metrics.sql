WITH calendar AS (
  -- Build a simple date dimension
  SELECT
    day AS cal_date,
    EXTRACT(YEAR FROM day)    AS cal_year,
    EXTRACT(QUARTER FROM day) AS cal_quarter
  FROM UNNEST(
    GENERATE_DATE_ARRAY(DATE '2000-01-01', DATE '2035-12-31', INTERVAL 1 DAY)
  ) AS day
),
numbers_with_date AS (
  SELECT
    num.*,
    -- Convert 20180131-style int into a DATE
    PARSE_DATE('%Y%m%d', CAST(num.period_end_date AS STRING)) AS period_end
  FROM `bigquery-public-data.sec_quarterly_financials.numbers` AS num
)

SELECT
  nwd.company_name,
  prs.preferred_label,
  nwd.units,
  nwd.value,
  cal.cal_date     AS period_end_date,
  cal.cal_year     AS year,
  cal.cal_quarter  AS quarter
FROM numbers_with_date AS nwd
LEFT JOIN `bigquery-public-data.sec_quarterly_financials.presentation` AS prs
  ON prs.measure_tag = nwd.measure_tag
JOIN calendar AS cal
  ON cal.cal_date = nwd.period_end
WHERE cal.cal_year = 2025;
