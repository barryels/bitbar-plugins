#!/bin/bash

# io-reg
# time for i in {0..100}; do ioreg -n AppleSmartBattery -r; done
# Average Result:
# real    0m2.968s
# user    0m0.396s
# sys     0m2.455s

# pmset
# time for i in {0..100}; do pmset -g batt; done
# Average Result:
# real    0m1.623s
# user    0m0.636s
# sys     0m0.692s