#Generate UMAP and tSNE plots 

rule plots:
    input:
        get_data_path
    output:
        umap_plot = report(os.path.join(result_path,'{analysis}','plots','UMAP_plot.png'),
                              caption="../report/plots.rst",
                              category="{}_umap_seurat".format(config["project_name"]),
                              subcategory="{analysis}"),

        tsne_plot = report(os.path.join(result_path,'{analysis}','plots','tSNE_plot.png'),
                              caption="../report/plots.rst",
                              category="{}_tsne_seurat".format(config["project_name"]),
                              subcategory="{analysis}"),                     
                            
    resources:
        mem_mb=config.get("mem", "16000"),
    threads: config.get("threads", 1)
    conda:
        "../envs/seurat.yaml"
    log:
        os.path.join("logs","rules","plots_{analysis}.log"),
    params:
        partition=config.get("partition"),
    script:
        "../scripts/plots.R"

