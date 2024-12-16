include { SEQERAKIT } from './modules/seqerakit/main.nf'

workflow {

    yamls = Channel.fromPath(params.yamls, checkIfExists: true)
        .collect()
        .map { yamls ->
            def date = new Date().format('yyyy-MM-dd')
            [ 
                // add envs here
                [
                    TIME: date,
                    TOWER_API_ENDPOINT: params.endpoint
                ],
                yamls 
            ]
        }

    SEQERAKIT(yamls)
}