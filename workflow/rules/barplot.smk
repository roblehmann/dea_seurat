rule barplot:
    input:
        seurat_object = get_data_path,
    output:
        barplot = os.path.join(result_path,'{analysis}','plots','barplot.png'),
    resources:
        mem_mb=config.get("mem", "16000"),
    threads: config.get("threads", 1)
    conda:
        "../envs/seurat.yaml"
    log:
        os.path.join("logs","rules","{analysis}_barplot.log"),
    params:
        partition=config.get("partition"),
        assay = lambda w: annot_dict["{}".format(w.analysis)]["assay"],
        metadata = lambda w: annot_dict["{}".format(w.analysis)]["metadata"],
    script:
        "../scripts/barplot.R"
