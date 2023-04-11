#### A. Installer les Prérequis
```bash
clear;
sudo pacman -Sy --noconfirm python-pip;
sudo pacman -Sy --noconfirm python-pytorch-opt-rocm; # AVX2 (CPU)
git clone https://aur.archlinux.org/python-torchvision-rocm.git;
cd python-torchvision-rocm;
makepkg -si --noconfirm;
```

#### B. Télécharger le projet ([WIKI AMD](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Install-and-Run-on-AMD-GPUs))
```bash
clear;
cd $HOME;
rm -rf HOME/stable-diffusion 2>/dev/null;
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git $HOME/stable-diffusion;
cd $HOME/stable-diffusion;
python -m venv venv --system-site-packages;
source venv/bin/activate;
pip install -r requirements.txt;

# Fix:
# - [Bouton] yay -Sy --noconfirm ttf-ms-win10-auto;
# - [Xformers] pip uninstall xformers
```



#### C. Edition de la configuration
```bash
mkdir $HOME/stable-diffusion/models/Lora
sed -i -e 's/\#export COMMANDLINE_ARGS\=\"\"/export COMMANDLINE_ARGS\=\"--skip-torch-cuda-test --precision full --no-half\"/g' $HOME/stable-diffusion/webui-user.sh;
sed -i '/^export COMMANDLINE_ARGS=*/a export PYTORCH_HIP_ALLOC_CONF="garbage_collection_threshold:0.6,max_split_size_mb:128\"' $HOME/stable-diffusion/webui-user.sh;
sed -i '/^export PYTORCH_HIP_ALLOC_CONF\=.*/a export PYTORCH_CUDA_ALLOC_CONF\=\"garbage_collection_threshold\:0.6,max_split_size_mb:128\"' $HOME/stable-diffusion/webui-user.sh;
```

##### D. Ajout de models
```bash
# XSarchitectural-12NightMoonsci-fi (civitai.com) | 36 Mo
wget https://civitai.com/api/download/models/30627 -O $HOME/stable-diffusion/models/Lora/XSarchitectural-12NightMoonsci-fi.safetensors;

# Coyote (Kemono Friends) (civitai.com)
wget https://civitai.com/api/download/models/4980  -O $HOME/stable-diffusion/models/Lora/Sci-Fi_Diffusion_v1.0.safetensors;

#Furry Girl (civitai.com) | 73 Mo
wget https://civitai.com/api/download/models/24691 -O $HOME/stable-diffusion/models/Lora/Furry-girl.safetensors;

# Sevens Mix [Furry Model] (civitai.com) | 2 Go
wget https://civitai.com/api/download/models/13268 -O $HOME/stable-diffusion/models/Stable-diffusion/sevens-mix-furry-model.safetensors;

# FaeTastic (civitai.com) | 2 Go
wget https://civitai.com/api/download/models/16553           -O $HOME/stable-diffusion/models/Stable-diffusion/faetastic_.safetensors;
wget https://civitai.com/api/download/models/16553?type=VAE  -O $HOME/stable-diffusion/models/VAE/kl-f8-anime2.ckpt;

# https://huggingface.co/Deltaadams/HentaiDiffusion/tree/main
```

#### E. Logiciel de Surveillance
```bash
sudo pacman -Sy --noconfirm radeontop;
```

##### F. Lancement
```bash
cd $HOME/stable-diffusion;
sh webui.sh;
radeontop -c;
```

##### G. SystemD
```bash

webui.sh: 
 clone_dir="stable-diffusion"


echo "[Unit]
Description=Stable Diffusion AUTOMATIC1111 Web UI service
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=marc
ExecStart=/usr/bin/env bash /home/marc/stable-diffusion/webui.sh
StandardOutput=append:/var/log/sdwebui.log
StandardError=append:/var/log/sdwebui.log

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/sdwebui.service;

systemctl daemon-reload;
systemctl disable sdwebui.service;
systemctl stop    sdwebui.service;
systemctl start   sdwebui.service;
systemctl status  sdwebui.service;
systemctl enable  sdwebui.service;
```


##### X. Autre
``` 
# https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Optimizations
# --skip-torch-cuda-test
# --medvram
# --opt-split-attention 
# --precision full
# --no-half
```
