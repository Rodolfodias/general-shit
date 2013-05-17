#!/usr/bin/env python
# -*- coding: utf-8 -*-

import psutil  		# sudo apt-get install python-psutil

while 1:
    encontrou=0
    var = raw_input("Processo a procurar?\n")

    for proc in psutil.process_iter():
        if proc.name == var:
            try:
                path=proc.cmdline[4].split('/')[3].split('.')[0]  # no final tem de ser 4
                print path
#                path=path.split('/')
 #               path=path.pop(4)
  #              path=path.split('.')
   #             path=path.pop(0)
            except IndexError:
                path = "Processo sem configs"
	    print "Processo %s | %f %% de memória ocupada | Configs: %s" % (proc.name, proc.get_memory_percent(),path)
#            nfields = len(proc.split()) - 1
#            for row in proc[1:]:
#                print row.split(None, nfields)
	    encontrou=1
    if not encontrou: 
        print "Esse processo não está a correr."
