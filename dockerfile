 #Defini l'Os
FROM debian:bullseye-slim
#Installation du serveur apache2
RUN apt-get update && apt-get install -y apache2 && rm -rf /var/lib/apt/lists/*
#Creation dossier moncv
RUN mkdir /var/www/moncv/
#Copie dossier site dans dossier mon cv docker
COPY ./site /var/www/moncv/
#Definir les permissions
RUN chown -R www-data:www-data /var/www/moncv
#copie du virtualhost 
COPY ./moncv.conf /etc/apache2/sites-available/moncv.conf
#Desactivation initialisation du nouveau et reactivation de default 
RUN a2dissite 000-default.conf && a2ensite moncv.conf && a2enmod rewrite

EXPOSE 80
CMD ["apache2ctl","-D","FOREGROUND"]
