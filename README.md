
ssiu/docker-webmail-lite
==============================

*forked from [afterlogic/docker-webmail-lite](https://github.com/afterlogic/docker-webmail-lite)*

Out-of-the-box [AfterLogic WebMail Lite](http://www.afterlogic.org/webmail-lite) image

Includes Apache and PHP setup based on [tutum/lamp package](https://github.com/tutumcloud/lamp)


**Depends on: [docker-compose](https://docs.docker.com/compose/install)**

Install docker-compose according to https://docs.docker.com/compose/install/

## Update docker-compose.yaml

 - Change MySQL Root Password, replace CHANGE_ME with password you desire
 - Change port mappings to fit your needs
 - Change bind mount volumes according to your needs, such as SSL certificates (currently comment out)

Creating the image
------------------

        docker-compose build


Running docker image
--------------------

Start your image binding the external port 80:

        docker-compose up -d

and access the container via web browser at https://localhost[:port]/


Accessing AdminPanel Interface
------------------------------

To configure WebMail Lite installation, log into AdminPanel interface using URL like https://localhost[:port]/?install/ to check if all dependencies are met

Default credentials are set to **superadmin** with empty password


Licensing Terms & Conditions
----------------------------

Content of this repository is available in terms of [AGPLv3 license](http://www.gnu.org/licenses/agpl-3.0.en.html) (see `LICENSE` file)
