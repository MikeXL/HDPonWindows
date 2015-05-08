
# Science Log 13.56 0429.15

I know, I know, this is about HDP on windows. But why not give linux a bit love even though I was not, am not, will not be a fan.

It is actually very simple to get Linux sandbox up and running

1. log into azure portal
2. create a virtual machine
3. pick up HDP2.2 sandbox
4. add a certificate for SSH
5. enjoy (well, change the hive.execution.engine to tez then enjoy)


Here are the steps to generate ssh certificate and also the private/public keys


    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ~/enterprise.key -out ~/enterprise.pem
    mv enterprise.key .ssh/id_rsa
    chmod 600 .ssh/id_rsa
    openssl x509 -inform pem -in enterprise.pem -outform der -out enterprise.cer


Here is how you would forward the ports

    ssh -L 9000:sandbox:80 -L 8000:sandbox:8000 -L 8088:sandbox:8088 mike@enterprise.cloudapp.net


LLAP 🖖
