{{ config(materialized = 'view'
         ,tags        = ['genpact']
         ) 
}}

SELECT
/*
 * WHEN         WHO            WHAT 
 * ------------ -------------- -------------------------------------------------------------------
 * 12-SEP-2024  PCROSS         SNF-7100 initial
 * 18-SEP-2024  JSTOPANSKY     SNF-7100 updated to use REF for src_credit_consent_check_history
 *                                      instead of SOURCE.
 *
 */
       h.application_number::NUMBER                                                                                                 AS application_number
      ,h.report_status                                                                                                              AS report_status
      ,h.bureau_name_hierarchy                                                                                                      AS bureau_name_hierarchy
      ,h.bureau_name                                                                                                                AS bureau_name
      ,h.score_band                                                                                                                 AS score_band
      ,h.application_status                                                                                                         AS application_status
      ,CONVERT_TIMEZONE('UTC','America/Los_Angeles',TO_TIMESTAMP_NTZ(h.pulled_date,'MM/DD/YYYY HH12:MI:SS PM'))                     AS pulled_date
      ,h.application_created_date::DATE                                                                                             AS application_created_date
      ,h.score                                                                                                                      AS score
      ,CONVERT_TIMEZONE('UTC','America/Los_Angeles',TO_TIMESTAMP_NTZ(h.application_final_decision_date,'MM/DD/YYYY HH12:MI:SS PM')) AS application_final_decision_date
      ,CONVERT_TIMEZONE('UTC','America/Los_Angeles',TO_TIMESTAMP_NTZ(h.application_last_modified_date,'MM/DD/YYYY HH12:MI:SS PM'))  AS application_last_modified_date
      ,h.state                                                                                                                      AS state
      ,h.zip                                                                                                                        AS zip
      ,h.bureau_dob_year                                                                                                            AS bureau_dob_year
      ,h.loaded_at                                                                                                                  AS loaded_at

FROM {{ref('src_credit_consent_check_history')}} h
WHERE h.bureau_name IS NOT NULL