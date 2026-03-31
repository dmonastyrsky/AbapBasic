CLASS zcl_98_01_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_98_01_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Inline Declaration

    DATA(my_var1) = `Hello World`. " Тип STRING определяется автоматически
    DATA(my_var2) = 17.            " Тип I (Integer) определяется автоматически
    DATA(my_var3) = my_var2.       " Тип берется из my_var2
    DATA(my_var4) = my_var2 + my_var3. " Результат сложения двух целых чисел

    out->write( my_var1 ).
    out->write( my_var2 ).
    out->write( my_var3 ).
    out->write( my_var4 ).



  ENDMETHOD.


ENDCLASS.
