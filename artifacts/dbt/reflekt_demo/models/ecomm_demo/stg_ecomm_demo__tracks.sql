{{
  config(
    materialized = 'view'
  )
}}

with

source as (
    select *
    from {{ source('ecomm_demo', 'tracks') }}
    where received_at < get_date()
),

renamed as (
    select
        id as event_id,
        event_text as event_name,
        original_timestamp as original_tstamp,
        sent_at as sent_at_tstamp,
        received_at as received_at_tstamp,
        timestamp as tstamp,
        anonymous_id,
        user_id,
        context_ip as ip,
        context_library_name as library_name,
        context_library_version as library_version,
        context_page_path as page_path,
        context_page_referrer as page_referrer,
        context_page_title as page_title,
        context_page_url as page_url,
        context_user_agent as user_agent,
        'track'::varchar as call_type,
        'ecomm_demo'::varchar as source_schema,
        'tracks'::varchar as source_table,
        'segment/ecommerce/Page_Viewed/1-0.json'::varchar as schema_id
    from source
)

select * from renamed
