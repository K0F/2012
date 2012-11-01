#!/bin/bash
watch -n 5 'iwlist wlan0 scanning > ./data/scan.txt'
