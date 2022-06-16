sudo docker prune -a
sudo docker build -t duckmang/satisfactory .
sudo rm satisfactory.tar
sudo docker save duckmang/satisfactory > satisfactory.tar
sudo chown "$USER:$(id -gn)" satisfactory.tar
