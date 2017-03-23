users:

{% for nextuser in ['user1','user2','user3'] %}
  {{ nextuser }}:
    fullname: {{ nextuser }}
    empty_password: True 
    shell: /bin/bash
    home: /home/{{ nextuser }}
    user_dir_mode: 700
    createhome: True
    sudouser: True
    sudo_rules:
      - ALL=(ALL) NOPASSWD:ALL
    ssh_auth:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtCHxI+hn3QZzQDR/oq+SEWtgrXiAmpw5Czhr8VVHAO0gnA9mCIPfQk7LsIdB0DF5CBvu4ekFlFSgfHaDkm+ZZzGybT9oAPvtKR3yilz/rzeSZxQBNGNOEgsyv1/bXl7M/N778sBeEYud2uAE/jztQmb2Gth1vwub9YuJPdS/wKXoeR1aP1WXQBMCBLBwSeI684rYYInvCZxOWYm8NCo7k3FlTYa1F+Ppa/f62JD40FrKa58CXAg2TDxZjXS4UmWWc++9cJ2KuLO7nbHpst/ZUK66pseHKwLvO/+9iE3+IHBnMkmH4KfBANhVBw4zpjF+naY86Ih4F8vpokW/GNEYD salt-demo-keys
{% endfor %}
