# Windows 10 Vagrant Box ready for DNI electrónico (Spain's electronic National ID)

This repo contains Vagrantfile and necessary elements to build a Windows 10 Vagrant Box ready for using an USB reader that accepts electronic Spanish ID. This is intended for people who do not have to physlical Windows machine but that require accessing Spain's on-line administration (at National, Regional or local level) making use of his/her electronic DNI (National ID)

This box includes the following elements:

* Firefox (some regional or local administrations work only with this browser)

* Chrome (National Revenue/Tax works well with this one)

* Internet Explorer (National Revenue/Tax works well with this one as well)

* Autofirma (digital signature application to sign PDF's and so on)

* Drivers for the USB SmartCard readers compatible with DNIe 3.0

## Usage

You have to use the VirtualBox GUI in order to access the graphic console, if you access the box via Remote Desktop you will not have access to the SmarCard Reader, this is a security configuration that comes with every Windows OS. The Vagrantfile provided here enables the VirtualBox gui precisely for that purpose.

In order to make use of the DNIe from Firefox browser you have to do a manual configuration:

1. Within Firefox go to Options -> Privacy and Security -> Security Devices

2. Click on `Load`, type any name (v.g. `DNIe`) and browse to choose the following dll file: `C:\Windows\System32\DNIeCMx64.dll`
