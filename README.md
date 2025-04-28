1. How the script handles arguments and options:

It loops through any arguments starting with - first.

Sets flags (show_line_numbers, invert_match) based on the options given.

After options are parsed, expects two arguments: search_string and filename.

Validates the presence of both and checks if the file exists.

2. How the structure would change if supporting regex or more options (-i, -c, -l):

I would switch from manual parsing to using getopts (a built-in shell tool for better options parsing).

Add flags for case-insensitivity -i, count matches -c, or list filenames with matches -l.

For regex support, the matching would switch from grep -i to grep -E -i (for extended regex).

The script would become modular — separate parsing, searching, and output into different functions.

3. Hardest part and why:

Correctly handling combined options like -vn and -nv without using a full options parser was tricky.

Also ensuring case-insensitive matching with grep while managing inversion (-v) required careful boolean logic.
