WITH A AS (
  SELECT date_format(from_unixtime("timestamp"/1000), '%Y-%m-%d %h:%i:%s') AS event_date 
  FROM "cm-latam-waf-db"."2020")
SELECT DISTINCT A.event_date, webaclid, terminatingruleid, terminatingruletype, action, httprequest.clientip, httprequest.uri, COUNT(DISTINCT A.event_date) AS count
FROM "cm-latam-waf-db"."2020", A
WHERE A.event_date LIKE '2020-11-18%'

GROUP BY A.event_date, webaclid, terminatingruleid, terminatingruletype, action, httprequest.clientip, httprequest.uri
ORDER BY count DESC, A.event_date DESC
limit 20