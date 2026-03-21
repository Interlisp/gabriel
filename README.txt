How to run Gabriel NEW-BENCH-* in Medley

1) Start Medley from a terminal:
   ./medley -a -e -n

2) In the Medley:
   (PSEUDOHOST 'GABRIEL "{UNIX}/path/to/cloned/gabriel/")

3) Load the benchmark(replace N with 1–4):
   (LOAD "{GABRIEL}<benchmarks>NEW-BENCH-N.")

4) Run it:
   (BENCH-N "{GABRIEL}<tools>" "{GABRIEL}<benchmarks>" "{GABRIEL}<Results>")

