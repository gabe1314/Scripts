WITH A AS (
  SELECT date_format(from_unixtime("timestamp"/1000), '%Y-%m-%d %h:%i:%s') AS event_date 
  FROM "cm-latam-waf-db"."2020")
SELECT A.event_date, webaclid, terminatingruleid, terminatingruletype, action, httprequest, httprequest.clientip, httprequest.uri
FROM "cm-latam-waf-db"."2020", A
WHERE A.event_date LIKE '2020-11-%'
limit 15