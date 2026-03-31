CLASS zcl_98_05_processing_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_98_05_processing_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Declarations
**********************************************************************

    " comment/uncomment these line for different result types
    TYPES t_result TYPE p LENGTH 8 DECIMALS 2.  "1234567890123.45
    TYPES t_result2 TYPE p LENGTH 8 DECIMALS 0.
    TYPES t_result3 TYPE i.

    DATA result TYPE t_result.
    DATA result2 TYPE t_result2.
    DATA result3 TYPE t_result3.

    DATA the_date TYPE d VALUE '20260324'.

* Calculations
**********************************************************************
    " comment/uncomment these lines for different calculations

    result = 2 + 3.
*    result = 2 - 3.
*    result = 2 * 3.
*    result = 2 / 3.
*
    result2 = sqrt( 2 ).
    result3 = ipow( base = 2 exp = 3 ).
*
*    result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
    result = 8 * 7 - 6 / 5 + 4.

* Output
**********************************************************************

    out->write( result ).
    out->write( result2 ).
    out->write( result3 ).

    out->write( |Результат: { result NUMBER = USER }| ).

    out->write( |{ the_date }| ).          " => '19891130', внутрішній формат
    out->write( |{ the_date DATE = ISO }| ). " => '1989-11-30', вивід у форматі ISO
    out->write( |{ the_date DATE = USER }| ). " => '11/30/1989', '30.11.1989', залежно від

    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.

    out->write( |{ my_number }|  ).                 " Стандартний вивід
    out->write( |{ my_number NUMBER = USER }|  ).     " => '-273.15' або '-273,15' (залежно від профілю користувача)
    out->write( |{ my_number SIGN   = RIGHT }|   ).   " => '273.15-' (знак мінуса переноситься в кінець)
    out->write( |{ my_number STYLE  = SCIENTIFIC }| )." => '-2.7315E+02' (експоненційний запис)


    DATA part1  TYPE string VALUE `Hello`.
    DATA part2  TYPE string VALUE `World`.

    " Перший варіант: злиття рядків без пробілу
    out->write( part1 && part2 ).

    " Другий варіант: злиття рядків із додаванням пробілу через шаблон | |
    out->write( part1 && | | && part2 ).


  ENDMETHOD.
ENDCLASS.
