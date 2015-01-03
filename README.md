# Vagrant WordPress Mozilla Brasil

## Sobre a Box

Versão web server criada a partir do repositório [mozilla-brasil-packer-debian](https://github.com/cynthiapereira/mozilla-brasil-packer-debian).

Abaixo segue uma lista de alguns pacotes já inclusos na box, sem a execução do provisionamento.

### Nginx
Version: `1.2.1`

nginx nginx-common nginx-full

### MySQL
Version: `5.5.40`

mysql-server-5.5 mysql-client-5.5

user: `mozillabrasil`

pass: `mozillabrasil`

database: `mozillabrasil`

### PHP
Version: `5.4.35`

php-pear php5-cli php5-common php5-curl php5-dev php5-fpm php5-gd php5-imagick php5-imap php5-mcrypt php5-memcache php5-mysql composer

### Node.js
Version: `v0.10.35`

npm `2.1.16` bower `1.3.12` grunt-cli `v0.1.13` gulp `3.8.10` yeoman `1.3.3`

### Extras
colordiff dos2unix gettext imagemagick ntp rsync subversion unzip vim vim-common vim-runtime vim-tiny

## Provisionador

Executa um simples script shell em bash.

A ideia é criar versões alternativas em [Ansible](https://docs.vagrantup.com/v2/provisioning/ansible.html), [Puppet Apply](https://docs.vagrantup.com/v2/provisioning/puppet_apply.html) e [Chef Solo](https://docs.vagrantup.com/v2/provisioning/chef_solo.html).

O que esse script shell faz:

+ Configura um novo VirtualHost para o WordPress.
+ Instala o [WP-CLI](http://wp-cli.org).
+ Instala a última versão do WordPress.
+ Habilita o modo Debug do WordPress.

### WordPress

url: `http://wp.mozillabrasil.dev`

user: `mozillabrasil`

pass: `mozillabrasil`

email: `admin@wp.mozillabrasil.dev`

#### Tema WoMoz

Para instalar e ativar o tema do WoMoz execute estes comandos:

````
vagrant ssh
cd /srv/www/wp.mozillabrasil.dev/
wp theme install https://github.com/mozillabrasil/womoz.mozillabrasil.org.br/archive/master.zip
wp theme activate womoz.mozillabrasil.org.br-master
````


## Recomendações

+ Instale o plugin [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) com o comando `vagrant plugin install vagrant-hostsupdater` para criar automaticamente uma entrada no seu arquivo `hosts` apontando para o domínio `http://wp.mozillabrasil.dev/` que será acessado através do browser.

+ Se você não quiser instalar o plugin, pode adicionar manualmente no seu arquivo `hosts` a seguinte linha: `192.168.33.103 wp.mozillabrasil.dev`

## Créditos e Licença

Inspirado no: [Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV)

Licença: [Mozilla Public License, version 2.0](LICENSE)


