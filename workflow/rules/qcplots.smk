# make QC plots
rule qcplot:
    input:
        get_data_path
    output:
        dea_qcplots = report(os.path.join(result_path,'{analysis}','plots','DEA_qcplot.png'),
                              caption="../report/qcplots.rst",
                              category="{}_dea_seurat".format(config["project_name"]),
                              subcategory="{analysis}"),
    resources:
        mem_mb=config.get("mem", "16000"),
    threads: config.get("threads", 1)
    conda:
        "../envs/seurat.yaml"
    log:
        os.path.join("logs","rules","qc_{analysis}.log"),
    params:
        partition=config.get("partition"),
        assay = lambda w: annot_dict["{}".format(w.analysis)]["assay"],
        metadata = lambda w: annot_dict["{}".format(w.analysis)]["metadata"],
        control = lambda w: annot_dict["{}".format(w.analysis)]["control"],
    script:
        "../scripts/qcplots.R"
