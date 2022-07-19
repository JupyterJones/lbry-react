This repository/site contains PHP files. I recomend using VisualCode as an editor because by installing a free extension Marketplace Visual Code can double as a PHP file server.   
------ This was the Extension used to create this project. ------
PHP Server v3.0.2
brapifra 839,905 users
Serve your Project with PHP
------------------------------------------------------------------
As the HTML site you are viewing live you will find many tips and ideas. However, when served as an PHP site many additional features can be viewed.



$ lsof -i tcp:3000
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
php     8588 jack    5u  IPv4 220151      0t0  TCP localhost:3000 (LISTEN)

Then kill the roceess Is PID
$ kill -9 8588  
