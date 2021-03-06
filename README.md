# Welcome to MARTI

![MARTI Logo](extras/www/new_images/MARTI-logo-white-bkgd.png)

## What Is MARTI?

The Mission Analysis and Research of Threat Intelligence (MARTI) is a modification to [CRITs](#what-is-crits) that enables the creation of collaborative communities for cyber threat intelligence sharing. MARTI incorporates STIX(TM) and TAXII(TM), standards developed by The MITRE Corporation under funding from the Department of Homeland Security (DHS). MARTI was developed by the Johns Hopkins University Applied Physics Laboratory (JHU/APL) under internal funding in 2016 to support a new concept called the Integrated Threat Analysis Capability (ITAC) to observe globally, protect nationally, and defend locally. 

The ITAC represents an analysis center, such as a State Fusion Center, Joint Operations Center (JOC), or Information Sharing Analysis Organization (ISAO). The ITAC can also be an analytical capability that can be added to existing environments to coordinate responses to distributed cyber threats. MARTI is based on the Dec 2015 version of [CRITs](https://github.com/crits/crits/commit/af358a3e2897f92c13bb2de0bd0c0dd4e9455882) and [CRITs Services](https://github.com/crits/crits_services/commit/f5b92a40240d76d2f3667abebd043c45d85ffae4) and adds the following features to CRITs:

- Auto-polling and auto-inboxing for STIX(TM) messages to be shared via the taxii_service
- Releasability sets an object to auto-inbox and sends to the selected feed whenever a field is modified
- Traffic Light Protocol (TLP) per the DHS standard
- Sightings based on the STIX(TM) format
- Cyber Kill Chain based on the Lockheed Martin publication
- Comments are sent via the STIX(TM) message unless marked private
- Sample and Email TLOs can be downloaded as an Intelligence Report (INTREP) that puts all fields into a Word or text document
- Some CRITs Top Level Objects (TLOs) are commented out of MARTI for ease of training new analysts, but can be un-commented for experienced users

Refer to the MARTI Deployment Guide and MARTI Configuration Guide the documentation folder for additional information.

## What Is CRITs?

CRITs is a web-based tool developed by MITRE, which combines an analytic engine with a cyber threat database that not only serves as a repository for attack data and malware, but also provides analysts with a powerful platform for conducting malware analyses, correlating malware, and for targeting data. These analyses and correlations can also be saved and exploited within CRITs. CRITs employs a simple but very useful hierarchy to structure cyber threat intelligence. This structure gives analysts the power to 'pivot' on metadata to discover previously unknown related content.

Visit their [website](https://crits.github.io) for more information, documentation, and links to community content such as their mailing lists and IRC channel.

# Dependencies
---
MARTI has the following dependencies:
- Python
- MongoDB
- Apache Web Server
- STIX(TM) and TAXII(TM)

# Installation
---
MARTI can be installed manually or automated.

The [manual](#manual) install instructions below are a replica of the CRITs manual install instructions.

The [automated](#automated-install) instructions below were developed by the MARTI team to automate the manual CRITs installation [production](#production-install) process.

---

## Automated Install

The automated install script sets up the environment by installing the Python libraries needed to properly run bootstrap and then also sets up the Apache SSL options (many of which are done manually in the [production](#production-crits-install) section).

This script was developed and verified on a fresh install of Ubuntu 16.04 server amd64.

Assuming you cloned the marti and marti-services into /opt/marti/marti and /opt/marti/marti-services respectively, run the [marti-install](script/marti-install.sh) script. 

```bash
/opt/marti/marti/script/marti-install.sh
```

If you cloned MARTI into a different location you can change the DIR variable before running the script.

```python
##############################################################################
#                            Global variables                                #
##############################################################################
...
DIR=/opt/marti/marti
```

NOTE: Make sure to write down the temporary password during the 'Install MARTI' step. If you forget, you will need to use manage.py to reset it (see CRITs documentation).

![Marti-Install-Menu](images/marti-install.png)

Running ONLY Option 1 and then exiting will setup the machine as in the section [quick install using bootstrap](#quick-install-using-bootstrap-non-ssl-useful-for-development). You can then user the server script (described in that section) to start the server.

To setup the machine for production use (Apache and SSL), you MUST run options 1 -> 2 -> 3 (IN ORDER). 

Options 4 and 5 are optional but recommended. The following describes each item in the menu:


1. Install MARTI

    This option installs any dependencies needed to run the bootstrap script from the [quick install using bootstrap](#quick-install-using-bootstrap-non-ssl-useful-for-development) section. It then runs that bootstrap script to finish the install.
    When asked to create/start the database, select 'Y'.
    In the next menu, select 'a' for "add admin user". 
    
    ![Bootstrap Menu](images/bootstrap_menu.png)
    
   Leave the organization name BLANK, as an organization doesn't currently exist and entering a name will cause the admin to not be created. Write down the temporary password because you will need this to log into the MARTI console after the installation is finished.

   ![Add User](images/add_user.png)

    Once the user is added, select 'q' to quit and continue with the installation. IMPORTANT: Do Not Start the Server!

       
2. Create Temporary SSL Cert

    This option sets up a temporary SSL cert to be used with the Apache setup. 


3. Setup Apache Instance

    This option is dependent on options 1 and 2. This will install Apache and set the appropriate files to allow MARTI to run via Apache with SSL.


4. Initialize Log File

    This was taken from the CRITs production install [wiki](https://github.com/crits/crits/wiki/Production-grade-CRITs-install#installing-the-codebase). This step was taken from the CRITs production installation wiki. It sets up a "crits" user for logging and cron jobs. Though the administrator will likely not use this account or password, it is advised to select a strong password, because a weak password could pose a security risk.


5. Adjust TCP for Many Users

    This was taken from the CRITs production install [wiki](https://github.com/crits/crits/wiki/Production-grade-CRITs-install#adjust-tcp-server-parameters) and helps with the heavy traffic flow typical in production environments. 


6. Start MARTI Server

    This option starts the Apache server. It will only work if the Apache/SSL version was installed.


Review the install script for additional information on how the settings and configurations are implemented.

---

## Manual Install

CRITs is designed to work on a 64-bit architecture of Ubuntu or RHEL6 using Python 2.7. Installation has beta support for OSX using Homebrew. It is also possible to install CRITs on CentOS.

If you require the use of a 32-bit OS, you will need to download 32-bit versions of the pre-compiled dependencies.

The following instructions assume you are running Ubuntu or RHEL6 64-bit with Python 2.7. If you are on RHEL which does not come with Python 2.7, you will need to install it. If you do, ensure all python library dependencies are installed using Python 2.7. Also, make sure you install mod_wsgi against the Python 2.7 install if you are looking to use Apache. More information on this can be found in the Github wiki at https://github.com/crits/crits/wiki/Common-Questions.

### Quick install using bootstrap (non-ssl, useful for development)

CRITs comes with a bootstrap script which will help you:

* Install all of the dependencies.
* Configure CRITs for database connectivity and your first admin user.
* Get MongoDB running with default settings.
* Use Django's runserver to quickly get you up and running with the CRITs interface.

Run the following:

```bash

    sh script/bootstrap
```

Once you've run bootstrap once, do not use it again to get the runserver going, as it would be going through the install process again. Instead use the server script:

```bash

    sh script/server
```

### Production install

If you are looking for a more permanent and performant CRITs installation or just interested in tweaking things, read more about setting up CRITs for [production](https://github.com/crits/crits/wiki/Production-grade-CRITs-install).

