#!/bin/bash

rsync /vagrant/files/ / -rti &&
  systemctl restart collectd &&
  systemctl status collectd
