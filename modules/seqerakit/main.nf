process SEQERAKIT {
    label 'process_single'

    // NOTE: Needs dev version of seqerakit so this isn't correct YET
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/seqerakit:0.4.9--pyhdfd78af_0':
        'biocontainers/seqerakit:0.4.9--pyhdfd78af_0' }"

    input:
    tuple val(envs), path("???.yaml")

    output:
    val envs            , emit: envs
    tuple path("*.json"), emit: json, optional: true
    path "versions.yml" , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def env_cmd = envs.collect { "export ${it.key}='${it.value}'"  }.join('; ')
    """
    $env_cmd
    seqerakit ${args} *.yaml

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        seqerakit: \$(seqerakit --version | cut -f2 -d ' ')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    """
    touch fake.json

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        seqerakit: \$(seqerakit --version | cut -f2 -d ' '')
    END_VERSIONS
    """
}
