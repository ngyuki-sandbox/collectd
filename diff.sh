#!/bin/bash

LANG=C exec diff -ru / /vagrant/files/ | grep -v '^Only in' | colordiff
