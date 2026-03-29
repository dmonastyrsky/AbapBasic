*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING i_carrier_id      TYPE /dmo/carrier_id
                i_connection_id   TYPE /dmo/connection_id
                i_airport_from_id TYPE /dmo/airport_from_id
                i_airport_to_id   TYPE /dmo/airport_to_id
      RAISING   cx_abap_invalid_value.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

  PRIVATE SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

*    DATA airport_from_id    TYPE /dmo/airport_from_id.
*    DATA airport_to_id      TYPE /dmo/airport_to_id.
*
*    DATA carrier_name TYPE /dmo/carrier_name.

    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/carrier_name,
      END OF st_details.

    DATA details TYPE st_details.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.
  METHOD constructor.
    " TODO: parameter I_AIRPORT_FROM_ID is only used in commented-out code (ABAP cleaner)
    " TODO: parameter I_AIRPORT_TO_ID is only used in commented-out code (ABAP cleaner)

    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION NEW cx_abap_invalid_value( ).
    ENDIF.

*    SELECT SINGLE
*    FROM /dmo/connection
*    FIELDS  airport_from_id,
*            airport_to_id,
*            carrier_id,
*            connection_id
*    WHERE carrier_id = @i_carrier_id
*         AND connection_id = @i_connection_id
*    INTO ( @airport_from_id, @airport_to_id,
*            @carrier_id, @connection_id ).

    SELECT SINGLE FROM /DMO/I_Connection
      FIELDS DepartureAirport,
             DestinationAirport,
             \_Airline-Name as AirlineName
      WHERE AirlineID    = @i_carrier_id
        AND ConnectionID = @i_connection_id
*      INTO ( @airport_from_id, @airport_to_id, @carrier_name ).
      INTO CORRESPONDING FIELDS OF @details.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW cx_abap_invalid_value( ).
    ENDIF.

*    me->carrier_id      = i_carrier_id.
    me->connection_id   = i_connection_id.
*    me->airport_from_id = i_airport_from_id.
*    me->airport_to_id   = i_airport_to_id.
  ENDMETHOD.

  METHOD get_output.
*    APPEND |--------------------------------|             TO r_output.
*    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
*    APPEND |Connection:  { connection_id   }|             TO r_output.
*    APPEND |Departure:   { airport_from_id }|             TO r_output.
*    APPEND |Destination: { airport_to_id   }|             TO r_output.

    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-AirlineName }| TO r_output.
    APPEND |Connection:  { connection_id }|              TO r_output.
    APPEND |Departure:   { details-DepartureAirport   }| TO r_output.
    APPEND |Destination: { details-DestinationAirport }| TO r_output.
  ENDMETHOD.
ENDCLASS.
