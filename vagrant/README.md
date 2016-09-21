# Vagrant
This directory contains the needed files for setting up the Vagrant development environment for the jboss\_admin project.

## Setup
Setup instructions not specific to either WildFly or JBoss EAP.

1. `> cd puppet-jboss_admin`
2. `bundle`

## WildFly 7.x

By default the vagrant instance will install the latest WildFly 7.x version for developing the jboss\_admin module against.

### Instructions
1. `> cd puppet-jboss_admin`
2. `> vagrant up`

## JBoss EAP 6.x

To develop the jboss\_admin module against JBoss EAP 6.x a zip of JBoss EAP 6.x will need to be provided to the Vagrant instance to install. Follow the instructions here to have the vagrant instance install JBoss EAP 6.x rather then WildFly.

### Instructions
The instructrions for setting up the development environment to use JBoss EAP is seperated into two stages. Creating the JBoss EAP ZIP and secondly starting the Vagrant instance using that ZIP.

#### Create JBoss EAP Zip
The JBoss EAP Zips provided by Red Hat all have different root directories which does not play well with Puppet. At the very minimum the ZIP provided by Red Hat needs to be changed to have a consistent root directory of **jboss-eap**. This is also a good chance to apply any needed patches as Red Hat provided ZIPs do not contain micro version patches.

1. Download JBoss EAP 6.x from http:://access.redhat.com
2. Extract the ZIP
3. Apply any patches
4. rename the root directory to`jboss-eap`
5. `> zip -r jboss-eap.zip jboss-eap`
  * It is important that the root directory of the zip be `jboss-eap` for Puppet to be able to properly extract the contents
6. Take note of the `jboss-eap.zip` location, later refered to as **PATH_TO_JBOSS_EAP_ZIP**

#### Start the Development Instance
1. `> cd puppet-jboss_admin`
2. `> JBOSS_EAP=PATH_TO_JBOSS_EAP_ZIP vagrant up`
  * **PATH_TO_JBOSS_EAP_ZIP**: the full path to the ZIP created in [Create JBoss EAP Zip](#Create JBoss EAP Zip) section
