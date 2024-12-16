# seqerakit in Nextflow

This is a simple example of how to use seqerakit in Nextflow.

## Requirements

- Nextflow
- seqerakit

## Quickstart

Set the following environment variables:

```
export ORGANIZATION_NAME=seqeralabs
export AWS_WORKSPACE_NAME=scidev-aws
export AZURE_WORKSPACE_NAME=scidev-azure
export GCP_WORKSPACE_NAME=scidev-google
export SLURM_WORKSPACE_NAME=scidev-slurm
```

Run the pipeline:

```
nextflow run <repo>
```

Or if cloned locally:

```
nextflow run .
```

## Usage

You need to run the pipeline with:
 - The seqerakit YAML files
 - The environment variables for each seqerakit YAML file in the process

Nextflow will run a single process for all YAML files together.

### Setting environment variables

#### Using a local `.env` file

You need to set the following environment variables:

- `ORGANIZATION_NAME`
- `AWS_WORKSPACE_NAME`
- `AZURE_WORKSPACE_NAME`
- `GCP_WORKSPACE_NAME`
- `SLURM_WORKSPACE_NAME`

Create a `.env` file with the following:

```
export ORGANIZATION_NAME=seqeralabs
export AWS_WORKSPACE_NAME=scidev-aws
export AZURE_WORKSPACE_NAME=scidev-azure
export GCP_WORKSPACE_NAME=scidev-google
export SLURM_WORKSPACE_NAME=scidev-slurm
```

#### Using Nextflow config

You can also use the `nextflow.config` file to set the environment variables.

```
env {
    ORGANIZATION_NAME=seqeralabs
    AWS_WORKSPACE_NAME=scidev-aws
    AZURE_WORKSPACE_NAME=scidev-azure
    GCP_WORKSPACE_NAME=scidev-google
    SLURM_WORKSPACE_NAME=scidev-slurm
}
```

Which will be passed to the `SEQERAKIT` process as `envs`.

### Using the right YAML files

The pipeline will read in the yaml files from the `yamls` parameter. By default, this will point to `assets/launch/hello.yml` to launch this YAML file. You can use standard Nextflow path rules, e.g. globs and wildcards to match any number of YAML files.

### Only using a subset of the YAML contents

In addition to pointing to specific YAML files, you can use the `targets` parameter to only run a subset of the YAML contents. This is useful if you want to run a subset of the YAML files in a single process.

```
params {
    targets = "launch"
}
```

This will only run the `launch` target in the YAML file. You can specify multiple targets, e.g. `pipeline,launch`. See [seqerakit documentation](https://github.com/seqeralabs/seqera-kit?tab=readme-ov-file#specify-targets) for more details.

### Using the `endpoint` parameter

The `endpoint` parameter is used to specify the Seqera API endpoint. This is used to communicate with Seqera cloud. Set this to the appropriate deployment.

```
params {
    endpoint = "https://api.cloud.seqera.io"
}
```
