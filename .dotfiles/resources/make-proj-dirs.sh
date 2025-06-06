#!/usr/bin/env bash

usage='make-proj-dirs.sh: Create project scaffolding for data science/ML
and general projects.
USAGE: bash make-proj-dirs.sh <artifact-type> <artifact-name>
where-
artifact-type-
- For ML projects: ml_proj, ml_ana, ml_model, ml_deploy, ml_deploy_ana, ml_deploy_model
- For general projects: proj
artifact-name: Name of artifact
EXAMPLE: bash make-proj-dirs.sh ana verify-deployment'

# DUMMY_REPO_PATH='/Users/ashim/resources/repos/local/make-proj-dirs-dummy-repo'

MKDIR="mkdir -p"
TOUCH="touch"


# function deprecated_make_dummy_repo() {
#     [[ -d "$DUMMY_REPO_PATH" ]] && return
# 
#     old_dir="$( pwd )"
# 
#     $MKDIR $DUMMY_REPO_PATH
#     cd $DUMMY_REPO_PATH
#     git init
#     touch .gitignore
# 
#     git add .
#     git commit -m 'Initial commit'
# 
#     cd "$old_dir"
# }

function make_repo() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    git init $ARTIFACT_NAME
    cd $ARTIFACT_NAME
    touch .gitignore
    git add .
    git commit -m 'Initial commit'

    cd "$old_dir"
}

function make_proj() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    make_repo $ARTIFACT_NAME

    cd $ARTIFACT_NAME
    touch README.rst

    $MKDIR docs/ docs/journal/ docs/publish docs/publish/docs/ docs/publish/figures/
    touch docs/index.rst docs/journal/index.rst docs/todos.org

    $MKDIR references/

    $MKDIR scratch/

    cd "$old_dir"
}


function make_ml_proj() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    # make_dummy_repo
    # git clone $DUMMY_REPO_PATH $ARTIFACT_NAME
    make_repo $ARTIFACT_NAME

    # TODO Add content to .gitignore (as these will be added as submodules)
    # - analysis/
    # - jobs/

    cd $ARTIFACT_NAME
    touch README.rst
    touch README.rst

    $MKDIR docs/ docs/journal/ docs/publish docs/publish/docs/ docs/publish/figures/
    touch docs/index.rst docs/journal/index.rst docs/todos.org

    $MKDIR data/ data/raw/ data/raw/external/

    $MKDIR notebooks/

    $MKDIR analysis/

    $MKDIR model/

    # $MKDIR other-stage-if-required/

    $MKDIR references/

    $MKDIR scratch/

    cd "$old_dir"
}

function make_ml_ana() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    # make_dummy_repo
    # git clone $DUMMY_REPO_PATH $ARTIFACT_NAME
    make_repo $ARTIFACT_NAME
    git submodule add $old_dir/$ARTIFACT_NAME

    cd $ARTIFACT_NAME
    touch README.rst Makefile
    
    $MKDIR docs/ docs/publish/ docs/publish/docs/ docs/publish/figures/
    touch docs/index.rst

    $MKDIR data/ data/raw/ data/raw/external/ data/interim/ data/processed/

    $MKDIR notebooks/

    $MKDIR src/
    touch src/run.sh

    cd "$old_dir"
}

function make_ml_model() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    # make_dummy_repo
    # git clone $DUMMY_REPO_PATH $ARTIFACT_NAME
    make_repo $ARTIFACT_NAME
    git submodule add $old_dir/$ARTIFACT_NAME

    cd $ARTIFACT_NAME
    touch README.rst Makefile

    $MKDIR docs/ docs/publish/ docs/publish/docs/ docs/publish/figures/
    touch docs/index.rst

    $MKDIR data/ data/raw/ data/raw/external/ data/interim/ data/processed/

    $MKDIR src/
    touch src/run.sh

    cd "$old_dir"
}

function make_ml_deploy() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    make_repo $ARTIFACT_NAME

    cd $ARTIFACT_NAME

    $MKDIR data/ data/raw/ data/raw/external/ data/interim/ data/processed/

    $MKDIR analysis/

    $MKDIR model/

    $MKDIR scratch/

    cd "$old_dir"
}

function make_ml_deploy_ana() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    make_repo $ARTIFACT_NAME
    git submodule add $old_dir/$ARTIFACT_NAME

    cd $ARTIFACT_NAME
    touch Makefile README.rst

    $MKDIR data/ data/raw/ data/raw/external/ data/interim/ data/processed/

    $MKDIR src/
    touch src/run.sh

    $MKDIR logs/

    cd "$old_dir"
}

function make_ml_deploy_model() {
    ARTIFACT_NAME=$1
    old_dir="$( pwd )"

    make_repo $ARTIFACT_NAME
    git submodule add $old_dir/$ARTIFACT_NAME

    cd $ARTIFACT_NAME
    touch Makefile README.rst

    $MKDIR data/ data/raw/ data/raw/external/ data/interim/ data/processed/

    $MKDIR src/
    touch src/run.sh

    $MKDIR logs/

    cd "$old_dir"
}

function main() {
    ARTIFACT_TYPE="$1"
    ARTIFACT_NAME="$2"

    if [[ $ARTIFACT_TYPE == 'proj' ]]; then
        make_proj $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_proj' ]]; then
        make_ml_proj $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_ana' ]]; then
        make_ml_ana $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_model' ]]; then
        make_ml_model $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_deploy' ]]; then
        make_ml_deploy $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_deploy_ana' ]]; then
        make_ml_deploy_ana $ARTIFACT_NAME
    elif [[ $ARTIFACT_TYPE == 'ml_deploy_model' ]]; then
        make_ml_deploy_model $ARTIFACT_NAME
    fi
}


if [[ $# -ne 2 ]]; then
    echo "$usage"
    exit 1
fi
ARTIFACT_TYPE="$1"
ARTIFACT_NAME="$2"

main $ARTIFACT_TYPE $ARTIFACT_NAME

