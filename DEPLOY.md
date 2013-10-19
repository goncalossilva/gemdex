# Deploy instructions

## Setup your public key

1. Locate your local public SSH key file. (Usually ~/.ssh/id_rsa.pub)
2. Execute the following locally: (You'll need your Linode server's root password.)

    cat ~/.ssh/id_rsa.pub | ssh root@rumble.iamto.me "cat >> ~/.ssh/authorized_keys"

## Deploy the project to the server

To deploy a new version to the server, do the following on the project root:

    # if you have migrations to run
    bin/cap deploy:migrations
    # otherwise
    bin/cap deploy

## Public address

You can reach the project homepage at http://rumble.iamto.me
