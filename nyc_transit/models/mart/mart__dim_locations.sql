Select
  {{ dbt_utils.star(ref('taxi+_zone_lookup')) }}
From 
{{ ref('taxi+_zone_lookup') }}