{{ config(materialized = 'table'
         ,tags        = ['genpact']
         ) 
}}

SELECT
/*
 * WHEN         WHO            WHAT 
 * ------------ -------------- --------------------------------------------------------------------------------------
 * 20-SEP-2024  PCROSS         SNF-7100 initial
 *
 */
       h.application_number
      ,h.report_status
      ,h.bureau_name_hierarchy
      ,h.bureau_name
      ,h.score_band
      ,h.application_status
      ,h.pulled_date
      ,h.application_created_date
      ,h.score
      ,h.application_final_decision_date
      ,h.application_last_modified_date
      ,h.state
      ,h.zip
      ,h.bureau_dob_year
      ,h.loaded_at

FROM {{ref('stg_credit_consent_check_history')}} h