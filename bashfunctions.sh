#!/usr/bin/env bash


#Secret files are details you do not want pushed to your docker contexts git repo.
#For example git-credentials and git-config files.
#Place your secret files at a chosen location, here ../contextsecrets is relativly addressed
secretlocation='../../contextsecrets'

declare -a secretfiles=(".git-credentials" ".gitconfig")
declare -a secretdirs=(".ssh")

add_secrets () {

    for secretfile in "${secretfiles[@]}"
    do 
        secretfilelocation="$secretlocation/$secretfile"
        if [[ -f $secretfilelocation ]]; then
            cp $secretfilelocation . 
        fi
    done

    for secretdir in "${secretdirs[@]}"
    do 
        secretdirlocation="$secretlocation/$secretdir"
        if [[ -d $secretdirlocation ]]; then

            cp -r $secretdirlocation .
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

    for secretdir in "${secretdirs[@]}"
    do
        if [[ -d $secretdir ]]; then 
            rm -rf $secretdir
        fi 
    done

}

#Your env files, which contain docker ENV notation should be kept in the secretlocation.
declare -a envfiles=("awsenvs" "digioenvs")

add_envs_to_dockerfile_tmp () {

    cp Dockerfile $1
    echo $'\n' >> $1
    for envfile in "${envfiles[@]}"
    do 
        envfilelocation="$secretlocation/$envfile"
        if [[ -f $envfilelocation ]]; then
            cat $envfilelocation >> $1
        fi
    done
}
