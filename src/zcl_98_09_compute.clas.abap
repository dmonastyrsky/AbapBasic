CLASS zcl_98_09_compute DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_98_09_compute IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA number1 TYPE i VALUE -8.
    DATA number2 TYPE i VALUE 3.

    DATA result TYPE p LENGTH 8 DECIMALS 2.
    DATA(result2) = number1 / number2.

    result = number1 / number2.

    DATA(output) = |{ number1 } / { number2 } = { result }|.

    out->write( output ).
    out->write( |{ number1 } / { number2 } = { result2 }| ).

  ENDMETHOD.
ENDCLASS.
