#!/bin/bash

logFn=/mnt/data_ssd/dmro.txt
# logFn=/dev/null  # PB why? Because broken? Checkout service's StandardOutput

function dmro_echo() {
    echo -e "<DMRO> $(date) - ${*}" | tee -a ${logFn}
}

#
# Return 0 if we CANNOT write on root filesystem (expected behaviour during boot). 1 otherwise
#
function dmro_test_write() {
    local touchFn=/a
    local lsFn=$(dirname ${touchFn})  # too much verbose
    lsFn=${touchFn}

    dmro_echo "*  *  *  *  *  *  *  *  *  *  *  *  *"
    ls -l ${lsFn} 2>&1 | tee -a ${logFn}

    if /usr/bin/touch ${touchFn}; then
        dmro_echo "touch success: test FAILURE"
        ls -l ${lsFn} 2>&1 | tee -a ${logFn}
        rv=1
    else
        dmro_echo "touch failure: test SUCCESS"
        rv=0
    fi

    if [[ -f ${touchFn} ]]; then
        dmro_echo "removing file"
        rm ${touchFn} 2>&1 | tee -a ${logFn}
        if [[ -f ${touchFn} ]]; then
            dmro_echo "removing file: FAILURE"
        fi
    fi

    return ${rv}
}
