++       Cell 0 = 2
> +++++  Cell 1 = 5
[        Start loop
  < +    Add 1 to Cell 0
  > -    Subtract 1 from Cell 1
]        End loop (when Cell 1 == 0)
< +++++ Add 5 to Cell 0
++++++  Add 6 to Cell 0
.        Output Cell 0 (should be 2+5+5+6=18 which is 0x12, not printable)
        So let's make it print a character
++++++++
++++++++
++++++++
++++++++
++++     Add 48 to get ASCII '0' + 18 = 'B' (66)
.
