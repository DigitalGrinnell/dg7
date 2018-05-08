Digital Grinnell's dg7 Module
=============================

Digital Grinnell can be found at https://digital.grinnell.edu.

## This repo contains the source code and supporting files for Digital Grinnell's dg7 module.

The **dg7** module contains functions which are **specific to Digital Grinnell** 
and Islandora v7.

The module does very little on its own, but provides numerous 'hook' functions 
designed to customize Digital Grinnell behavior.


Deployment
----------
This module is expected to reside in **../sites/default/modules/dg7**.

Installation
------------
dg7 can be installed and enabled in a manner typical of all Drupal modules.  General 
practice is to clone this repository to ../sites/default/modules in order to create 
the necessary dg7 directory structure. 

Please Note...
--------------
If you recieve an error message from IMI like the following...

    `IMI hook dg7_islandora_multi_importer_remote_file_get was invoked and was unable to find a file matching 'lib_cycloneyearbook_part2.pdf' in '/mnt/storage' for ingest. Make sure that you have mounted your files as '/mnt/storage', and that they can be read by 'www-data'!  See https://github.com/DigitalGrinnell/dg7/blob/master/README.md for additional details.`

...you may find it necessary to do something like this on the server/host that's running your ingest...

    `sudo mount -t cifs -o username=mcfatem //storage.grinnell.edu/LIBRARY/mcfatem/PHPP_Content /mnt/storage`
