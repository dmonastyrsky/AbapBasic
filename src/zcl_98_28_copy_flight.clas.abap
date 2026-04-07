CLASS zcl_98_28_copy_flight DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_98_28_copy_flight IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lv_source_table) = '/DMO/FLIGHT'.
    DATA(lv_target_table) = 'Z98FLIGHT'.
    DATA lt_flights TYPE STANDARD TABLE OF z98flight WITH EMPTY KEY.

    TRY.
      out->write( |Step 1: Reading data from { lv_source_table }...| ).

      SELECT FROM (lv_source_table)
        FIELDS
          client, carrier_id, connection_id, flight_date,
          price, currency_code, plane_type_id, seats_max, seats_occupied
        INTO CORRESPONDING FIELDS OF TABLE @lt_flights.

      IF sy-subrc <> 0.
        out->write( |WARNING: No data found in { lv_source_table }. Table is empty.| ).
      ELSE.
        out->write( |Found { lines( lt_flights ) } rows to copy.| ).
      ENDIF.

      IF lt_flights IS NOT INITIAL.
        out->write( |Step 2: Preparing technical RAP fields (Admin Data)...| ).

        GET TIME STAMP FIELD DATA(lv_timestamp).

        LOOP AT lt_flights ASSIGNING FIELD-SYMBOL(<fs_flight>).
          <fs_flight>-local_created_by      = sy-uname.
          <fs_flight>-local_created_at      = lv_timestamp.
          <fs_flight>-local_last_changed_by = sy-uname.
          <fs_flight>-local_last_changed_at = lv_timestamp.
          <fs_flight>-last_changed_at       = lv_timestamp.
        ENDLOOP.

        out->write( |Step 3: Deleting existing data from { lv_target_table }...| ).
        DELETE FROM (lv_target_table).

        out->write( |Step 4: Inserting new data into { lv_target_table }...| ).
        INSERT (lv_target_table) FROM TABLE @lt_flights.

        IF sy-subrc = 0.
          COMMIT WORK.
          out->write( |SUCCESS: { lines( lt_flights ) } rows copied to { lv_target_table }.| ).
        ELSE.
          ROLLBACK WORK.
          out->write( |ERROR: Could not insert data. Check if table { lv_target_table } is active.| ).
        ENDIF.
      ELSE.
        out->write( |Nothing to copy. Source table is empty.| ).
      ENDIF.

    CATCH cx_sy_sql_error INTO DATA(lx_sql_error).
      ROLLBACK WORK.
      out->write( |DATABASE ERROR: { lx_sql_error->get_text( ) }| ).

    CATCH cx_root INTO DATA(lx_error).
      ROLLBACK WORK.
      out->write( |ERROR: { lx_error->get_text( ) }| ).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
