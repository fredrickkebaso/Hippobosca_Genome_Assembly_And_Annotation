#!/usr/bin/env nextflow

nextflow.enable.dsl=2

//ch = Channel.of(1, 2, 3, 4, 5, 7)
//value = Channel.value(3.14)
prot=Channel.fromPath("./")

process baseicexample {
    input:
    tuple(x,y)

    shell:
    """
    echo "$x"
    echo "$y"
    """
}

workflow {
    baseicexample(ch, value)
}
