sudo docker build -t satisfactory .
sudo rm satisfactory.tar
sudo docker save satisfactory > satisfactory.tar
sudo chown "$USER:$(id -gn)" satisfactory.tar
