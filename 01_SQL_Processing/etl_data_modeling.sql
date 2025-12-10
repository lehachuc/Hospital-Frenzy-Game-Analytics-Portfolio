-- Sql_Overview_Data
with raw_user_engagement as (
    select
    event_date
    , a.user_pseudo_id
    , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
    , a.app_version
    , upper(a.platform) as platform
    , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
          else a.country
    end as country
    , a.online_time
    , a.max_level
   
    , null as engagement_time_msec
    , a.ga_session_id
    , a.ga_session_number
    , "tutorial" as event_name
  from `jda-k1.mobile_games.tutorial` a
  where a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"


  union all


    select
    event_date
    , a.user_pseudo_id
    , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
    , a.app_version
    , upper(a.platform) as platform
    , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
          else a.country
    end as country
    , a.online_time
    , a.max_level
   
    , null as engagement_time_msec
    , a.ga_session_id
    , a.ga_session_number
    , "Level_End" as event_name
  from `jda-k1.mobile_games.level_end` a
  where a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"
)


, user_engagement as
  (select * except(r_asc, r_desc)
  , cast(null as STRING) as product_id_iap
  , cast(0 as float64) as rev_iap
  , cast(0 as float64) as rev_iaa
  , cast(null as STRING) placement
  , cast(null as STRING) ad_source
  , cast(null as STRING) ad_format
  from
    (select *
    , row_number() over(partition by advertising_id, event_date, cast(ga_session_number as int) order by event_date asc) r_asc
    , row_number() over(partition by advertising_id, event_date, cast(ga_session_number as int) order by event_date desc) r_desc
    from raw_user_engagement)
  where r_asc = 1
  or r_desc = 1)




, iap as (
  select
  event_date
  , a.user_pseudo_id
  , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
  , a.app_version
  , upper(a.platform) as platform
  , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
        else a.country
  end as country
  , a.online_time
  , a.max_level
  -- , a.max_res
  -- , a.player_id
  , null as engagement_time_msec
  , a.ga_session_id
  , a.ga_session_number
  , "in_app_purchase" as event_name
  , a.product_id as product_id_iap
  , cast(a.event_value_in_usd as float64) as rev_iap
  , cast(0 as float64) as rev_iaa
  , cast(null as STRING) as placement
  , cast(null as STRING) as ad_source
  , cast(null as STRING) as ad_format
  from `jda-k1.mobile_games.in_app_purchase` a
  -- where a._table_suffix >= "20250305"
  where a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"
)


, iaa as (
  select
    event_date
  , a.user_pseudo_id
  , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
  , a.app_version
  , upper(a.platform) as platform
  , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
        else a.country
  end as country
  , a.online_time
  , a.max_level
  -- , a.max_res
  -- , a.player_id
  , null as engagement_time_msec
  , a.ga_session_id
  , a.ga_session_number
  , "ad_impression" as event_name
  , cast(null as STRING) as product_id_iap
  , cast(0 as float64) as rev_iap
  , a.revenue as rev_iaa
  , a.placement
  , a.ad_source
  , a.ad_format
   
  from `jda-k1.mobile_games.ad_impression` a
  -- where a._table_suffix >= "20250715"
  where a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"
)




, result as (
  select 'Engage' as table_name
  , *
  from user_engagement
  union all
  select 'IAP' as table_name
  , *
  from iap
  union all
  select 'IAA' as table_name
  , *
  from iaa
)


, clean_install_date as
(select advertising_id, min(date(event_date)) as min_event_timestamp
from result
group by 1)


, final_result as
(select a.*
  , b.min_event_timestamp  as install_date
from result a
left join clean_install_date b on a.advertising_id = b.advertising_id
order by advertising_id, install_date asc)


select * from final_result
where app_version = "3.1.1"
and event_date <= "2025-08-10"
and event_date >= "2025-07-15"

-- Sql_Churn_Data
with raw_user_play_game as (
  select
    event_date
    , a.user_pseudo_id
    , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
    , a.app_version
    , upper(a.platform) as platform
    , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
          else a.country
    end as country
    , a.online_time
    , a.max_level
    , a.ga_session_id
    , a.ga_session_number
    , a.step_name as tutorial_step_name
    , a.step_id as tutorial_step_id
    , cast(null as int64) as Level_End_level
    , cast(null as int64) as Level_End_win
    , "tutorial" as event_name
  from `jda-k1.mobile_games.tutorial` a
  where 1=1
  and a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"


  union all


  select
    event_date
    , a.user_pseudo_id
    , case when a.advertising_id = "" then cast (a.vendor_id as string) else a.advertising_id end as advertising_id
    , a.app_version
    , upper(a.platform) as platform
    , case when a.country in ('None', 'N/A', '') or a.country is null then 'Unknown'
          else a.country
    end as country
    , a.online_time
    , a.max_level
    , a.ga_session_id
    , a.ga_session_number
    , cast(null as string) as tutorial_step_name
    , cast(null as int64) as tutorial_step_id
    , a.level as Level_End_level
    , a.win as Level_End_win
    , "Level_End" as event_name
  from `jda-k1.mobile_games.level_end` a
  where 1=1
  and a.advertising_id <> "0000-0000"
  and a.advertising_id <> "00000000-0000-0000-0000-000000000000"


)


select
*
from raw_user_play_game
where country in ("United States", "South Korea", "Japan", "Germany", "Australia", "France", "Belgium", "Italy", "United Kingdom", "Spain")
order by advertising_id, event_name asc

