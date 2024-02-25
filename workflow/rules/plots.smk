#Generate UMAP and tSNE plots 

rule plots:
    input:
        get_data_path
    output:
        umap_plot = os.path.join(result_path,'{analysis}','UMAP_plot.png'),
        tsne_plot = os.path.join(result_path,'{analysis}','tSNE_plot.png'),              
                            
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

