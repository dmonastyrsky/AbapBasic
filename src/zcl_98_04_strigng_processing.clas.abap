CLASS zcl_98_04_strigng_processing DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_98_04_strigng_processing IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

* Declarations
**********************************************************************
    TYPES t_amount TYPE  p LENGTH 8 DECIMALS 2.

    DATA amount   TYPE t_amount VALUE '3.30'.
    DATA amount1  TYPE t_amount VALUE '1.20'.
    DATA amount2  TYPE t_amount VALUE '2.10'.

    DATA the_date  TYPE d                     VALUE '19891109'.
    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.

    DATA part1 TYPE string VALUE `Hello`.
    DATA part2 TYPE string VALUE `World`.

* String Templates
**********************************************************************

    " comment/uncomment the following lines for different examples
    DATA(text) = |Hello World|.
    DATA(text2) = |Total: { amount } EUR|.
    DATA(text3) = |Total: { amount1 + amount2 } EUR|.

* Format Options
**********************************************************************

    "Date
    DATA(text4) = |Raw Date: { the_date             }|.
    DATA(text5) = |ISO Date: { the_date Date = ISO  }|.
    DATA(text6) = |USER Date:{ the_date Date = USER }|.

    "Number
    DATA(text7) = |Raw Number { my_number                    }|.
    DATA(text8) = |User Format{ my_number NUMBER = USER      }|.
    DATA(text9) = |Sign Right { my_number SIGN = RIGHT       }|.
*    DATA(text) = |Scientific { my_number STYLE = SCIENTIFIC }|.

* String expression (concatenation Operator)
**********************************************************************

    DATA(text10) = part1 && part2.
    DATA(text11) = part1 && | | && part2.
    DATA(text12) = |{ amount1 } + { amount2 }| &&
                 | = | &&
                 |{ amount1 + amount2 }|.


* Output
**********************************************************************

    out->write( text ).
    out->write( text2 ).
    out->write( text3 ).

    out->write( text4 ).
    out->write( text5 ).
    out->write( text6 ).

    out->write( text7 ).
    out->write( text8 ).
    out->write( text9 ).

    out->write( part1 && part2 ).
    out->write( text11 ).
    out->write( text12 ).

  ENDMETHOD.
ENDCLASS.
