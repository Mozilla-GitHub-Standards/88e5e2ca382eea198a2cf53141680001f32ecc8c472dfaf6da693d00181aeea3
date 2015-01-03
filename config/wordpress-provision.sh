#!/bin/bash

# Cria um novo VirtualHost
echo "Criando um novo VirtualHost..."
sudo cp /vagrant_data/nginx/wp.mozillabrasil.dev /etc/nginx/sites-available/wp.mozillabrasil.dev
echo "Feito."

# Cria o link simbólico do VirtualHost
echo "Criando o link simbólico do VirtualHost..."
sudo ln -s /etc/nginx/sites-available/wp.mozillabrasil.dev /etc/nginx/sites-enabled/wp.mozillabrasil.dev
echo "Feito."

# Remove o VirtualHost default do /etc/nginx/sites-enabled/ para evitar conflitos
echo "Removendo o VirtualHost default..."
sudo rm /etc/nginx/sites-enabled/default
echo "Feito."

# Reinicia o nginx
echo "Reiniciando o nginx..."
sudo service nginx restart &>/dev/null
echo "Feito."

# Instala o WP-CLI
echo "Instalando o WP-CLI... (esta operação pode demorar - depende da sua conexão com a internet.)"
git clone https://github.com/wp-cli/wp-cli.git /srv/www/wp-cli &>/dev/null
cd /srv/www/wp-cli
composer install &>/dev/null
sudo ln -sf /srv/www/wp-cli/bin/wp /usr/local/bin/wp
echo "Feito."

# Baixa a última versão do WordPress
echo "Baixando o WordPress... (esta operação pode demorar - depende da sua conexão com a internet.)"
cd /srv/www/
curl -L -O https://br.wordpress.org/latest-pt_BR.zip &>/dev/null
unzip latest-pt_BR.zip &>/dev/null
mv wordpress wp.mozillabrasil.dev
rm latest-pt_BR.zip
echo "Feito."

# Configura o banco de dados do WordPress já pré-estabelecido na box.
echo "Configurando o banco de dados..."
sudo -u vagrant -i -- wp core config --dbname=mozillabrasil --dbuser=mozillabrasil --dbpass=mozillabrasil --locale='pt_BR' --path=/srv/www/wp.mozillabrasil.dev --quiet --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'SCRIPT_DEBUG', true );
define( 'SAVEQUERIES', true );
PHP
echo "Feito."

# Instala o WordPress
echo "Instalando o WordPress..."
sudo -u vagrant -i -- wp core install --url=wp.mozillabrasil.dev --title="WP Mozilla Brasil Dev" --admin_name=mozillabrasil --admin_email="admin@wp.mozillabrasil.dev" --admin_password="mozillabrasil" --path=/srv/www/wp.mozillabrasil.dev --quiet
echo "Feito."

echo "O seu ambiente de desenvolvimento está pronto! Verifique http://wp.mozillabrasil.dev/"
