#!/usr/bin/env bash


#Secret files are details you do not want pushed to your docker contexts git repo.
#For example git-credentials and git-config files.
#Place your secret files at a chosen location, here ../contextsecrets is relativly addressed
secretlocation='../../contextsecrets'

declare -a secretfiles=(".git-credentials" ".gitconfig")

add_secrets () {

    for secretfile in "${secretfiles[@]}"
    do 
        secretfilelocation="$secretlocation/$secretfile"
        if [[ -f $secretfilelocation ]]; then
            cp $secretfilelocation . 
        fi
    done

}

remove_secrets () {

    for secretfile in "${secretfiles[@]}"
    do
        if [[ -f $secretfile ]]; then
            rm $secretfile
        fi
    done

}

#Your env files, which contain docker ENV notation should be kept in the secretlocation.
declare -a envfiles=("awsenvs" "digioenvs")

add_envs_to_dockerfile_tmp () {

    cp Dockerfile $1
    for envfile in "${envfiles[@]}"
    do 
        envfilelocation="$secretlocation/$envfile"
        if [[ -f $envfilelocation ]]; then
            cat $envfilelocation >> $1
        fi
    done
}
