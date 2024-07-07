-- Adding macros to convert flag to boolean.sql
{% macro convert_flag_to_boolean(column, true_val="Y", false_val="N", empty_val=" ") -%}
  (
    case
      when {{ column }} = '{{ true_val }}' then TRUE::boolean
      when {{ column }} = '{{ false_val }}' then FALSE::boolean
      when {{ column }} = '{{ empty_val }}' then NULL::boolean
      when {{ column }} is NULL then NULL::boolean
      else NULL::boolean  -- Ensure the else case is explicitly cast to boolean
    end
  )
{%- endmacro %}