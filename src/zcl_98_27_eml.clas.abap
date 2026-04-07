CLASS zcl_98_27_eml DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_98_27_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

    agencies_upd = VALUE #( ( agencyid = '070045' name = 'Modevi 29.03.2026' ) ).

    MODIFY ENTITIES OF /dmo/i_agencytp
           ENTITY /dmo/agency
           UPDATE FIELDS ( name )
           WITH agencies_upd
           FAILED DATA(ls_failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(ls_reported).

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
      out->write( 'Daten erfolgreich aktualisiert!' ).
      " out->write( ls_reported ).
    ELSE.
      out->write( 'Fehler aufgetreten!' ).
      " out->write( ls_failed ).
    ENDIF.

    SELECT SINGLE * FROM /DMO/I_AgencyTP
      WHERE AgencyID = '070045'
      INTO @DATA(ls_agency).

    IF sy-subrc = 0.
      out->write( ls_agency ).
    ELSE.
      out->write( 'Агентство з ID 070050 не знайдено.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
