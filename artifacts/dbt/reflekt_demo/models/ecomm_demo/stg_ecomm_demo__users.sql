{{
  config(
    materialized = 'view'
  )
}}

with

source as (
    select *
    from {{ source('ecomm_demo', 'users') }}
),

renamed as (
    select
        id as user_id,
        received_at as received_at_tstamp,
        context_ip as ip,
        context_library_name as library_name,
        context_library_version as library_version,
        context_page_path as page_path,
        context_page_referrer as page_referrer,
        context_page_search as page_search,
        context_page_title as page_title,
        context_page_url as page_url,
        context_user_agent as user_agent,
        'identify'::varchar as call_type,
        'ecomm_demo'::varchar as source_schema,
        'users'::varchar as source_table,
        'segment/ecommerce/Identify/1-0.json'::varchar as schema_id
    from source
)

select * from renamed
