### 0.1.1 / 2011-06-24

* No longer call super in {Warnings::Mixing#warn}, to prevent duplicate
  warnings being added to `$WARNINGS`.
* Moved the `at_exit` hook into `warnings/warnings` to ensure it is always
  loaded.

### 0.1.0 / 2011-06-24

* Initial release:
  * Respects `$VERBOSE` (`ruby -w`) and `$DEBUG` (`ruby -d`)
  * Search Warning Messages by:
    * Message
    * Source File
    * Source Method
  * Prints unique Warning messages upon exit.
  * ANSI Coloring.

