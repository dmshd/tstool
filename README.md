# tstool
## tool.sh
### Improving sass work 
It's a shell script I made for simplifying repetitive tasks when working 
on e-service portal theme.
#### How to use it
`mkdir ~/bin/ && cd ~/bin` if it doesn't exist yet then do a `git clone https://github.com/dmshd/tstool` 
Use ~/bin directory for your shell scripts to keep /usr/bin clean with just system packages placed by the OS. Someone somewhere on the internet told me to do it that way and says it is a better practice.  
Once the repository is cloned inside `~/bin` :  
`chmod +x ~/bin/tstool/tool.sh` to make it executable.
Then edit `~/.bashrc` and add this line at the end of the file `export PATH="$HOME/bin/tstool`  

If everything went well. You'll be able to use type and execute `tool.sh` from any dir.

At the moment the possibilities are :  

* `tool.sh --help` should helps
* `tool.sh -r or --restore nomcommune` will copy /nomcomune from /opt/....../static to /usr/...../static  
* `tool.sh -s or --save nomcommune` will restore import path(s) in nomcommune/style.sccs and copy from /usr/... to /opt/...
* `tool.sh -S or --switch nomcommune` will modify import path(s) in nomcommune/style.scss and sass the whole thing

These commands can be used from any directories.
All ideas, suggestions, code review, is welcome.

#### Ideas 
* ajouter le changement des variables du site-options.cfg hobo (global_title, slug, ...) pour switcher à la volée. Il faut paramétrer cela dans un trucmuche-extra.json et `sudo -u hobo-manage /chemin/vers/extra.json` 
 voir ticker entreouvert relatif  
* a `tool.sh --update nomcommune` that ssh connect to the right ts-prod adress and does a docker exec -ti nomcommune_blahblabhla_1 bash and then does an apt update && apt-install imio-publik-themes   
* checker si exsite `nomcommune/banner.jpg` et modifier la valeur de `$header-banner-image:` en fonction (true/false).
