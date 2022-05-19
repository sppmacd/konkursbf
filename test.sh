#!/bin/bash

rm -r output tmp
mkdir output tmp

test_echo() {
    echo "$*"
    echo !!! $* >>$log_file
}

run_testcase() {
    testcase_name=$(basename -s .bf $testcase)
    testcase_dir=../../output/$entry_bn/$testcase_name

    test_echo "  -- Testcase: $testcase"
    test_echo "    test $entry: $testcase"

    pushd $entry >/dev/null
        mkdir $testcase_dir
        cmd_output=$testcase_dir/output.bin

        ./build.sh run ../../$testcase 2>>$log_file >$cmd_output
        cmp $cmd_output ../../testcases/$testcase_name.out || return 1

        bench_output=$testcase_dir/bench-output.csv
        test_echo "    benchmark $entry: $testcase > $bench_output"
        hyperfine "./build.sh run ../../$testcase" --export-csv $bench_output >>$log_file 2>&1
    popd >/dev/null
}

for entry in entries/*; do
    entry_bn=$(basename $entry)
    mkdir output/$entry_bn
    log_file=$(realpath output/$entry_bn/log.txt)

    test_echo "--- Doing Entry Test $(basename $entry_bn)"
    build_sh_file=$entry/build.sh
    if [ ! -e $build_sh_file ]; then
        echo "$build_sh_file doesn't exist"
        continue
    fi

    test_echo "    build $entry"
    pushd $entry >/dev/null
        ./build.sh build >>$log_file 2>&1
    popd >/dev/null

    for testcase in testcases/*.bf; do
        run_testcase && printf "    TEST \e[32mPASS\e[m\n" || printf "    TEST \e[31mFAIL\e[m\n"
    done
done
