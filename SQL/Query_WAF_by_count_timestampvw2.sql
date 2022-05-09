WITH A AS (
  SELECT date_format(from_unixtime("timestamp"/1000), '%Y-%m-%d %h:%i:%s') AS event_date 
  FROM "sampledb"."cm_waf_table")
SELECT A.event_date, webaclid, terminatingruleid, terminatingruletype, action, httprequest.clientip, httprequest.uri, approx_distinct(DISTINCT A.event_date) AS count
FROM "sampledb"."cm_waf_table", A
WHERE A.event_date LIKE '2020-11-18%'
AND action = 'BLOCK'
GROUP BY A.event_date, webaclid, terminatingruleid, terminatingruletype, action, httprequest.clientip, httprequest.uri
ORDER BY count DESC, A.event_date DESC
LIMIT 50