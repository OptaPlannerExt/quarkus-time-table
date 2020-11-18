#!/bin/sh

unset MAVEN_CONFIG

if [ ! -d "/projects/quarkus-time-table/oc_client" ]
then	
	cd /projects/quarkus-time-table/	
	mkdir oc_client
	wget https://github.com/rohitralhan/occlient/raw/main/oc-4.6.3-linux.tar.gz
	tar -xvf oc-4.6.3-linux.tar.gz -C oc_client
	rm -rf oc-4.6.3-linux.tar.gz
	export PATH=$PATH:/projects/quarkus-time-table/oc_client
fi

export PATH=$PATH:${CHE_PROJECTS_ROOT}/quarkus-time-table/oc_client 

cd ${CHE_PROJECTS_ROOT}/quarkus-time-table 

oc login -u devadmin -p devadmin --server=https://api.cluster-ea09.ea09.example.opentlc.com:6443 

./mvnw quarkus:add-extension -Dextensions="openshift" 

./mvnw clean package -Dquarkus.kubernetes.deploy=true -Dquarkus.kubernetes-client.trust-certs=true
