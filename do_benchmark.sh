#!/bin/sh
#
#  do_benchmark.sh
#
#  Script to run Gabriel benchmarks in Medley.
#
#  Call with the benchmark file name as the first argument and
#  the benchmark function to call as the second argument.  For example:
#
#  $ do_benchmark.sh NEW-BENCH-1.lcom IL:BENCH-1 "$toolsDir" "$benchmarksDir" "$resultsDir"
#
#  Copyright 2026 Interlisp.org.
#

main() {
        MEDLEYDIR=/Users/kabirgupta/Documents/Interlisp/medley_folder/medley
        export MEDLEYDIR
        logindir=/tmp/benchmarks-$$
        mkdir -p "${logindir}"
        cmfile=${logindir}/hcfiles.cm

	cat >"${cmfile}" <<-EOF
	"

	(PROGN
          (IL:MEDLEY-INIT-VARS 'IL:GREET)
	  (SETQ SYSOUTGAG T)
	  (GCGAG 500)
	  (IL:FILESLOAD $1)
          (IL:SETQ IL:*UPPER-CASE-FILE-NAMES* NIL)
          (IL:SETQ IL:NO-HELP NIL)
	  ($2 $3 $4 $5)
          (IL:DRIBBLE)
          (IL:LOGOUT T)
	)

	"
	EOF

        # Make sure loadups/build is not included in HCFILES
        if [ -d "${MEDLEYDIR}/loadups/build" ]
        then
          touch "${MEDLEYDIR}/loadups/build/.skip"
        fi

        /bin/sh "${MEDLEYDIR}/scripts/medley/medley.command"     \
             --config -                                          \
             --id bench_+                                        \
             --geometry 1024x768                                 \
             --noscroll                                          \
             --logindir "${logindir}"                            \
             --greet -                                           \
             --rem.cm "${cmfile}"                                \
             --apps

}

main "$@"
