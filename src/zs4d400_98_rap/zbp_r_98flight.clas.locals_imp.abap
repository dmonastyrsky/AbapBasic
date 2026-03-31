CLASS lhc_zr_98flight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
              IMPORTING
                 REQUEST requested_authorizations FOR Flight
              RESULT result.
    METHODS validatePrice FOR VALIDATE ON SAVE
                  IMPORTING keys FOR Flight~validatePrice.
ENDCLASS.


CLASS lhc_zr_98flight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatePrice.
    DATA failed_record   LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    READ ENTITIES OF zr_98flight IN LOCAL MODE
         ENTITY Flight
         FIELDS ( Price )
         WITH CORRESPONDING #( keys )
         RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).

      IF flight-Price > 0.
        CONTINUE.
      ENDIF.

      failed_record-%tky = flight-%tky.
      APPEND failed_record TO failed-flight.

      reported_record-%tky = flight-%tky.
      reported_record-%msg = new_message( id       = 'Z98_MSG_FLIGHT'
                                          number   = '101'
                                          severity = ms-error ).
      reported_record-%element-Price = if_abap_behv=>mk-on.

      APPEND reported_record TO reported-flight.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
