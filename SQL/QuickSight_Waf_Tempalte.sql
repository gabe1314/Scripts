with d as (select
    waf.timestamp,
        waf.formatversion,
        waf.webaclid,
        waf.terminatingruleid,
        waf.terminatingruletype,
        waf.action,
        waf.httpsourcename,
        waf.httpsourceid,
        waf.HTTPREQUEST.clientip as clientip,
        waf.HTTPREQUEST.country as country,
        waf.HTTPREQUEST.httpMethod as httpMethod,
        map_agg(f.name,f.value) as kv
    from sampledb.jsonwaflogs_useast1 waf,
    UNNEST(waf.httprequest.headers) as t(f)
    group by 1,2,3,4,5,6,7,8,9,10,11)
    select d.timestamp,
        d.formatversion,
        d.webaclid,
        d.terminatingruleid,
        d.terminatingruletype,
        d.action,
        d.httpsourcename,
        d.httpsourceid,
        d.clientip,
        d.country,
        d.httpMethod,
        d.kv['Host'] as host,
        d.kv['User-Agent'] as UA,
        d.kv['Accept'] as Acc,
        d.kv['Accept-Language'] as AccL,
        d.kv['Accept-Encoding'] as AccE,
        d.kv['Upgrade-Insecure-Requests'] as UIR,
        d.kv['Cookie'] as Cookie,
        d.kv['X-IMForwards'] as XIMF,
        d.kv['Referer'] as Referer
    from d;