CLASS zcl_98_17_select_from_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_98_17_select_from_table IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    TRY.
        connection = NEW #( i_carrier_id = 'LH'
                 i_connection_id     = '0400'
                 i_airport_from_id   = 'FRA'
                 i_airport_to_id     = 'JFK' ).

        out->write( connection->get_output(  ) ) .
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
